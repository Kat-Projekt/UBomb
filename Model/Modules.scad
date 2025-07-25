include <Ubomb.scad>

// Normal Modules

Max = 1000;
Screw_d = 2;

module Wire ( ) 
{
    wire_base_thick = 3;
    cube ( [ wire_base_thick, wire_base_thick, 100 ], center = true );
}

module Wires ( ) {
    distance_thick = 1;
    padding = 10;
    distnace_2 = (module_l - padding * 2 ) / 5;
    
    connector_cable_d = 2;
    
    morsetto_h = 8;
    morsetto_w = 46.7;
    morsetto_d = 2.5;
    
    connector_w = 8;
    connector_d = 5;
    connector_dist = 8;
    
    M_total = 16;
    
    interferenza_cavo = 0.2;
    cavo_thick = 1.6;
    
    difference ( ) {
        BModule ( );
        
        // positive
        translate ( [module_l/2-morsetto_h/2-module_internal_wall,
                     -module_l/2+morsetto_w/2+module_internal_wall,
                     module_d/2 - M_total/2 - module_internal_wall + morsetto_d] )
        cube ( [morsetto_h,morsetto_w,M_total], center = true );
        
        translate ( [module_l/2-morsetto_h/2-module_internal_wall,
                     -module_l/2+morsetto_w/2+module_internal_wall
                     ] )
        // holes morsetto
        for ( i = [-2.5:2.5] )
        {
            minkowski ( )
            {
                translate ( [0,connector_dist * i] )
                cube ( [connector_w-4,connector_d-4, Max], center = true );
                sphere ( 2 , $fn = 16);
            }
        }
        // vite morsetto
        translate ( [module_indent_d+module_internal_wall+1+1,0])
        translate ( [module_l/2-morsetto_h/2-module_internal_wall,
                     -module_l/2+morsetto_w/2+module_internal_wall,0
                     ] )
        translate ( [0,connector_dist,module_d/2-module_internal_wall/2-M_total/2] )
        rotate (-90,[0,1,0])
        Screw ( );
        
        
        // holes other side
        translate ( [-module_l/2 + padding,-module_l/2 + padding,module_d/2 - distance_thick] )
        for ( i = [0:5] )
        {
            translate ( [0,i*distnace_2] )
            cylinder ( d = connector_cable_d, h = Max, center = true, $fn = 8 );
        }
        
        // cable passage
        translate ( [-module_l/2 + padding,0,module_d/2 - cavo_thick /2-cavo_thick] )
        translate ( [-connector_cable_d/2 - cavo_thick/2 + interferenza_cavo,0])
        cube ( [cavo_thick, module_l  , cavo_thick +1], center = true );
    }
}

module Button ( )
{
    translate ( [0,0, module_d/2 - module_internal_wall] )
    minkowski ( ) { 
        union ( )
        {
            cylinder ( d = 7, h = Max, $fn = 16 );
            cylinder ( d = 10, h = 2, $fn = 16 );
        }
        
        IcoSphere ( 0.3 );
    }
}

module Display ( )
{
    Dis_w = 30.6;
    Dis_l = 14.6;
    
    cube ( [Dis_w,Dis_l,Max], center = true );
    
}

module Single_Display ( )
{
    difference ( )
    {
        cube ( [ 13,17.5,Max ], center = true );
    
        // fins
        for ( i = [-1,1] )
        {
            translate ( [ 6.5*i,0, - Max/2 + module_d/2 - 1 ] )
            cube ( [ 1,1.5, Max ], center = true );
        }
        
    }
}

module Square_Led ( )
{
    cube ( [2.3,5.3,Max], center = true );
    
    translate ( [0,0,-Max/2 + module_d/2])
    cube ( [3,5.4, Max], center = true );
}

module Memory ( ) {
    Button_padding = 12;
    Led_padding = 7;

    difference ( ) {
        BModule ( );
        // 5 leds 
        for ( i = [-2:2] )
        {
            translate ( [25, Led_padding * i - 7])
            rotate ( 90 )
            Square_Led ( );
        }
        
        // 1 display
        translate ( [-6, 6] )
        Single_Display ( );
        
        // 4 buttons
        translate ( [-6,-19] )
        for ( i = [ -1.5:1.5] )
        {
            translate ( [ Button_padding * i,0 ])
            Button ( );
        }
        
    }
}

module Selettore ( ) {
    base = [ 17.3, 17.5,4 ];
    pirolino = [ 4.1,21, 4 ];
    
    pisellino = 3;
    pisellino_h = 2.5 + 4;
    
    shaft = 9;
    
    translate ( [0,0, module_d/2 - module_internal_wall + 1] )
    union ( )
    {
        translate ( [ 0,0,-base[2] / 2 ] )
        cube ( base, center = true );
        
        translate ( [ 0, ( pirolino[1]-base[1] ) /2,-base[2] / 2 ] )
        cube ( pirolino, center = true );
        
        translate ( [0,base[1]/2,-base[2]])
        cylinder ( d = pisellino, h = pisellino_h, $fn = 16 );
        
        cylinder ( d = shaft, h = Max, $fn = 32 );
    }
}

module MorseCode ( ) {
    Dis_w = 32;
    Dis_l = 16;

    difference ( ) {
        BModule ( );
        
        translate ( [-10.5,0] )
        Display ( );
        
        translate ( [+22,0] )
        Selettore ( );
        
        translate ( [+22,-20] )
        Button ( );
        
        translate ( [-10,20] )
        Led ( );
    }
}

module Password ( ) {
    Dis_w = 30;
    Dis_l = 14;
    Dis_Pad = 0;
    Button_Padd = 20;
    
    centering = [-7,0];
    

    difference ( ) {
        BModule ( );
        
        // Display hole
        translate ( centering )
        translate ( [ 0,Dis_Pad,0 ])
        cube ( [ Dis_w, Dis_l, Max ], center = true );
        
        // Submit button
        
        
        translate ( [ Dis_w/2+ 5,5])
        Button ( );
        
        // buttons
        translate ( centering )
        for ( i = [ -1.5:1.5] )
        {
            translate ( [ ( Dis_w/4 + 3.5) * i, Dis_Pad + Dis_l + 3 ])
            Button ( );
            
            
            translate ( [ ( Dis_w/4 + 3.5) * i, Dis_Pad - Dis_l - 3 ])
            mirror ( [0,1,0])
            Button ( );
        }
    }
    
    // suspenders for board
}

// Neady Modules

module Potentiometer ( ) {
    diameter = 15.8;
    internal_d = 14.5;
    internal_quare_h = 13;
    
    height = 19.4;
    
    mount_hole = 5.5;
    mount_dist = 4.5;
    
    
    operation_h = 4;
    board_h = 1.1;
    
    shaft = 4.7;
    
    translate ( [ 0,-1,-operation_h] )
    difference ( )
    {
        union ( )
        {
            translate ( [0,0,operation_h])
            mirror ( [ 0,0,1 ] )
            cylinder ( d = internal_d, h = Max, $fn = 64  );
            
            translate ( [-internal_d/2,0,operation_h])
            mirror ( [0,0,1] )
            cube ( [ internal_d, height - internal_d/2, Max ] );
        
            translate ( [0,0,-operation_h+board_h] )
            union ( )
            {
                translate ( [0,0,operation_h])
                mirror ( [ 0,0,1 ] )
                cylinder ( d = diameter, h = Max, $fn = 64  );
                
                translate ( [-diameter/2,0,operation_h])
                mirror ( [0,0,1] )
                cube ( [ diameter, height - diameter/2 + 1, Max ] );
            }
        }
        
        translate ( [0,height - diameter/2 + mount_hole/2 - mount_dist, board_h ])
        cylinder ( d = mount_hole, h = operation_h, $fn = 16 );
        
        translate ( [0,height - diameter/2 + mount_hole/2 - mount_dist ])
        translate ( [-mount_hole/2,0,board_h] )
        cube ( [ mount_hole, - mount_hole/2 + mount_dist + 1, operation_h ] );
    }
    
    // hole
    cylinder ( d = shaft, h = Max, center = true, $fn = 64 );
}

module Knob ( )
{
    Tichness = 1;
    Width = 3;
    
    Base_D = 20;
    
    Top_D = 10;
    
    Heignh = 5;
    
    n_H = 3;
    
    Champher = 1;
    
    Pisnelo = 10;
    
    difference ( )
    {
        translate ( [0,0,Champher ])
        union ( )
        {
            mirror ( [0,0,1] )
            cylinder ( d = Base_D, h = Champher, $fn = 50 );
            linear_extrude ( Heignh, scale = Top_D / Base_D )
            circle ( d = Base_D, $fn = 50 );
            
            translate ( [0,0,Heignh] )
            cylinder ( d = Top_D, h = n_H, $fn = 50 );
            
            
            translate ( [4.4,0] )
            scale ( [ 0.7,1 ] )
            cylinder ( d = Top_D, h = n_H + Heignh, $fn = 3 );
        }
        
        scale ( 0.8 )
        translate ( [0,0,Champher ])
        union ( )
        {
            mirror ( [0,0,1] )
            cylinder ( d = Base_D, h = Champher, $fn = 50 );
            linear_extrude ( Heignh, scale = Top_D / Base_D )
            circle ( d = Base_D, $fn = 50 );
            
        }
        translate ( [Tichness, Width] / -2 )
        translate ( [0,0,-Pisnelo])
        cube ( [Tichness, Width,Heignh + n_H + Champher + Pisnelo] );
    }
    
    translate ( [ 40,0])
    cube ( [Tichness, Width,Heignh + n_H + Champher + Pisnelo] );
}

module Knobs ( ) {
    knob_center = [0,5];
    indi_center = [0,25];
    angle = 20;
    distance_1 = 30;
    first_row_offset = [0,7];
    second_row_ofset = [0,-3];
    difference ( ) {
        union ( )
        {
            BModule ( );
            translate ( knob_center )
            rotate ( 90 + 45 )
            translate ( [-5,0,module_d/2-5] )
            cube ( [4,20,8], center = true );
            
            translate ( knob_center )
            rotate ( 90 - 45 )
            translate ( [0,5,module_d/2-5] )
            cube ( [4,20,8], center = true );
        }
        
        translate ( knob_center )
        translate ( [0,0,module_d/2] )
        mirror ( [ 0,1,0] )
        rotate ( 90 + 45 )
        Potentiometer ( );
        
        for ( i = [ -2.5:2.5 ] ) {
            translate ( knob_center + first_row_offset - [ sin ( angle * i ),cos ( angle * i ), ] * distance_1  )
            Led ( );
            
            translate ( knob_center + second_row_ofset - [ sin ( angle * i ),cos ( angle * i ), ] * distance_1  )
            Led ( );
        }
        
        // indicatori tempo
        for ( i = [ -1:1 ] ) {
            translate ( indi_center + [9,0] * i )
            Led ( );
        }
    }
    
}

// Base Plate 

module Base ( ) {
    Controller_Center = [ 0,10 ];
    Controller_w = 40.64 / 2; // center of holes
    Controller_l = 15.24 / 2;
    Support_H = 5;
    Screw = 2.5;
    Pad = 1.2 * 2;
    
    Pin_Center = [0,-20];
    Pin_H = 2.5;
    Pin_D = 3;
    Pin_W = 11;
    Pin_R = 1;
    difference ( ) {
        CModule ( );
        
        // removing pins
        translate ( Pin_Center )
        translate ( [ 0,0,-module_d/2 + Pin_D/2 + module_internal_wall] )
        cube ( [Pin_W,Pin_H,Pin_D], center = true );
       
       
        translate ( Pin_Center )
        translate ( [ 0,0,-module_d/2 + module_internal_wall /2] )
        cube ( [Pin_W - Pin_R, Pin_H - Pin_R, module_internal_wall + rounding * 3], center = true );
        
    }
    
    // adding suspenders
    translate ( Controller_Center )
    translate ( [ 0,0,-module_d/2 + Support_H])
    for ( i = [0:3] )
    {
        translate ( [ Controller_w * ( 1 - ( i % 2 ) * 2 ), 
                      Controller_l * ( 1 - ( ( i - i % 2 ) / 2 ) * 2 ) ] )
        difference ( ) {
            cylinder ( d = Screw + Pad, h = Support_H, $fn = 32 );
            cylinder ( d = Screw, h = Support_H, $fn = 20 );
        }
        
    }
}
// Base ( );

module Clean_Body ( )
{
    union ( )
    {
        // corpo centrale
        linear_extrude ( module_d, center = true )
        square ( module_l, center = true );
            
        // indents laterali
        for ( i = [ 1:4 ] ) 
        {
            rotate ( 90*i, [0,0,1])
            translate ( [0,module_l/2])
            rotate ( -90,[1,0,0] )
            linear_extrude ( module_indent_d, scale = [(module_indent_w)/(module_indent_d+module_indent_w),1] )
            square ( [ module_indent_w + module_indent_d, module_d], center = true );
        }
    }
}

module Buzzer ( )
{
    for ( j = [6,4,0] )
    for ( i = [ 0:j ] )
    {
        translate ( [cos ( 360 / j * i ), sin ( 360/j * i ) ] * j  )
        cylinder ( d=1, h= Max );
    }
}

module Center_Piece ( )
{
    difference ( )
    {
        minkowski ( )
        {
            Clean_Body ( );
            IcoSphere ( );
        }
        
        // internal
        translate ( [0,0,-module_internal_wall/2 - rounding/2 ] )
        linear_extrude ( module_d - module_indent_d + rounding, center = true )
        offset ( -module_internal_wall, $fn = 12 )
        projection(cut = true) Clean_Body ( );
     
        // remove bottom to make it flat 
        translate ( [0,0,-module_l-module_d/2+module_screw_cap_d])
        cube ( module_l*2,center = true );
        
        // Display
        Display ( );
        
        // 2 Led
        translate ( [0,20] )
        for ( i = [-1,1] )
        {
            translate ( [ 5 *i,0 ])
            Led ( );
        }
        
        // Buzzer
        translate ( [22,20] )
        Buzzer ( );
    }
}

module Base_Plate ( )
{
    difference ( )
    {
        union ( ) {
            // assi
            rotate ( -90 )
            mirror ( [1,0,0])
            translate ( [larghezza_modulo+rounding/2 + tollerance /2,0] )
            difference ( )
            {
                Separator ( 2,1 );
                translate ( [1.75,0] )
                Separator_Lateral_Holes ( 1 );
            }
            rotate ( -90 )
            mirror ( [1,0,0])
            translate ( [larghezza_modulo*2+body_separator_hole - tollerance /2,0] )
            difference ( )
            {
                Separator ( 2,1 );
                translate ( [1.75,0] )
                Separator_Lateral_Holes ( 1 );
            }
          
            // laterali top bot
            
            rotate ( -90 )
            mirror ( [1,0,0])
            translate ( [-body_separator_w/2-rounding/2 - tollerance,0] )
            difference ( ) {
                Separator ( 2,1 );
                translate ( [-larghezza_modulo * 4 + body_separator_w/2-rounding/2-tollerance,-body_separator_w,-rounding] )
                cube ( larghezza_modulo * 4 );
                
                translate ( [ 3, 0 ])
                Separator_Holes ( 2,1);
            }
            
            rotate ( -90 )
            mirror ( [1,0,0])
            translate ( [larghezza_modulo*3+body_separator_hole*2-rounding/2-tollerance*3/2,0] )
            difference ( ) {
                Separator ( 2,1 );
                translate ( [body_separator_w/2+tollerance,-body_separator_w,-rounding] )
                cube ( larghezza_modulo * 4 );
                
                translate ([1,0,0])
                mirror ( [1,0,0])
                Separator_Holes ( 2,1 );
            }
            
            
            // base Plate
            Base_W = ( larghezza_modulo ) * 2 + body_separator_hole * ( 2 - 1 ) + rounding+ tollerance*2;
            Base_H = ( larghezza_modulo ) * 3 + body_separator_hole * ( 3 - 1 ) + rounding *2 + tollerance;
            translate ( [-rounding/2-tollerance-1.5,-rounding - tollerance * 2,-4] )
            cube ( [ Base_W + 3, Base_H ,4 ] );
        }
    
        // holes
        lll = ( larghezza_modulo ) * 2 + body_separator_hole * ( 2 - 1 ) + rounding+ tollerance*2;
        
        for ( i = [0:2] )
        {   
            
            translate ( [0,lll / 2 * ( 0.5 + i )] )
            translate ( [lll,0] / 2 )
            union ( )
            {
                // cable holes
                translate ( [-50,0] )
                cylinder ( d = 40, h = 10000, center = true );
                translate ( [50,0] )
                cylinder ( d = 40, h = 10000, center = true );
                
                cube ( [100,40,1000], center = true );
                
                // screws
                translate ( [-lll/2 - 0.75,0,-2])
                Screw ( );
                translate ( [lll/2 - 1.4,0,-2])
                Screw ( );
            
            }
        }
        ll = ( larghezza_modulo ) * 2 + body_separator_hole * ( 2 - 1 );
        // base holes
        for ( i = [-1,1] )
        {
            translate ( [ll/2 + i * ll / 4 ,0])
            union ( )
            {
                mirror ( [0,0,1])
                translate ( [0,-0.5])
                cylinder ( d = 2, h = Max, $fn = 8 );
                
                translate ( [0,( larghezza_modulo ) * 3 + body_separator_hole * ( 3 - 1 ) + rounding+ tollerance*2-2.4])
                mirror ( [0,0,1])
                cylinder ( d = 2, h = Max, $fn = 8 );
            }
        
        }
    }
}

module Lateral_Plate ( )
{
    difference ( )
    {
        union ( )
        {
            // assi
            // Separator ( 3,0 );
            

            translate ( [larghezza_modulo+body_separator_w + (-larghezza_modulo-rounding/2- tollerance /2)*-1,0] )
            difference ( ) {
                Separator ( 3,0 );
                translate ( [body_separator_w/2+tollerance,-body_separator_w,-rounding] )
                cube ( larghezza_modulo * 4 );
                
                translate ([0.5,0,0])
                mirror ( [1,0,0])
                Separator_Holes ( 3,0 );
            }
                       
            translate ( [-larghezza_modulo-body_separator_w + (-larghezza_modulo-rounding/2- tollerance /2)*-1,0] )
            difference ( ) {
                Separator ( 3,0 );
                translate ( [-larghezza_modulo * 4 + body_separator_w/2-rounding/2-tollerance,-body_separator_w,-rounding] )
                cube ( larghezza_modulo * 4 );
                
                translate ( [ 3, 0 ])
                Separator_Holes ( 3,0 );
                
            } 
        }
    
        // holes
        lll = ( larghezza_modulo ) * 2 + body_separator_hole * ( 2 - 1 ) + rounding+ tollerance*2;
        
        for ( i = [0:2] )
        {   
            
            translate ( [0,lll / 2 * ( 0.5 + i )] )
            translate ( [lll,0] / 2 )
            union ( )
            {
                // cable holes
                translate ( [-50,0] )
                cylinder ( d = 40, h = 10000, center = true );
                translate ( [50,0] )
                cylinder ( d = 40, h = 10000, center = true );
                
                cube ( [100,40,1000], center = true );
                
                // screws
                translate ( [-lll/2 - 0.75,0,-2])
                Screw ( );
                translate ( [lll/2 - 1.4,0,-2])
                Screw ( );
            
            }
        }
        
    }
}

Lateral_Plate ( );
