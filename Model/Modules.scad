include <Ubomb.scad>

// Normal Modules

Max = 1000;
Screw_d = 2;

module Wire ( ) 
{
    wire_base_thick = 3;
    cube ( [ wire_base_thick, wire_base_thick, 100 ], center = true );
}

module Wires_Plaques ( )
{
    distance_thick = 1;
    padding = 10;
    distnace_1 = 7;
    distnace_2 = (module_l - padding * 2 ) / 5;
    
    difference ( )
    {
        union ( )
        {
            translate ( [-padding/2,-padding/2] )
            cube ( [ padding, 5*distnace_1 + padding, 2]);
            
            // mounting holes
            for ( i = [0.5,4.5] )
            {
                scale ( [1,1,0.07])
                translate ( [0,i*distnace_1,50*0.7] )
                scale ( 0.7 )
                Wire ( );
            }
        }
        for ( i = [0:5] )
        {
            translate ( [0,i*distnace_1] )
            Wire ( );
        }
    }
    
    translate ( [padding*2,0,0])
    difference ( )
    {
        union ( )
        {
            translate ( [-padding/2,-padding/2] )
            cube ( [ padding, 5*distnace_2 + padding, 2]);
            
            // mounting holes
            for ( i = [0.5,4.5] )
            {
                scale ( [1,1,0.07])
                translate ( [0,i*distnace_2,50*0.7] )
                scale ( 0.7 )
                Wire ( );
            }
        }
        for ( i = [0:5] )
        {
            translate ( [0,i*distnace_2] )
            Wire ( );
        }
    }
}

module Wires ( ) {
    distance_thick = 1;
    padding = 10;
    distnace_1 = 7;
    distnace_2 = (module_l - padding * 2 ) / 5;
    difference ( ) {
        BModule ( );
        
        // holes for cables
        translate ( [module_l/2 - padding,-module_l/2 + padding,module_d/2 - distance_thick] )
        for ( i = [0:5] )
        {
            translate ( [0,i*distnace_1] )
            Wire ( );
        }
        translate ( [-module_l/2 + padding,-module_l/2 + padding,module_d/2 - distance_thick] )
        for ( i = [0:5] )
        {
            translate ( [0,i*distnace_2] )
            Wire ( );
        }
        
        // holes for mounting
        translate ( [module_l/2 - padding,-module_l/2 + padding,module_d/2 - distance_thick] )
        for ( i = [0.5,4.5] )
        {
            translate ( [0,i*distnace_1] )
            scale ( 0.7 )
            Wire ( );
        }
        translate ( [-module_l/2 + padding,-module_l/2 + padding,module_d/2 - distance_thick] )
        for ( i = [0.5,4.5] )
        {
            translate ( [0,i*distnace_2] )
            scale ( 0.7 )
            Wire ( );
        }
    }
}

// Wires_Plaques ( );
Wires ( );

module Button_Top ( )
{
    
}

module Button ( ) {
    difference ( ) {
        BModule ( );
        translate ( [module_l/2 - 6.5,-module_l/2 + 22.5 ] )
        cube ( [ 7,39, 1000 ],center = true );
    }
}

module KeyPads ( ) {
    difference ( ) {
        BModule ( );
        
    }
}

module Simon_Button ( ) 
{
    size = 20;
    radius = size / 2 * sqrt ( 5 );
    brim = 2;
    
    button_attach_w = 1;
    button_attach_d = 4;
    
    
    
    difference ( )
    {
        union ( ) {
        
            intersection ( )
            {
                translate ( [ 0,0, size /2])
                cube ( size, center = true );
                intersection_for ( i = [0:3] )
                {
                    rotate ( 90 * i )
                    translate ( [size/2,0])
                    sphere ( r = radius, $fn = 50);
                }
            }
            
            // brim
            translate ( [0,0,-brim / 2])
            cube ( [size + brim, size + brim, brim ], center = true );
        
        }
        
        translate ( [ 0,0,size*2.6])
        rotate ( 90, [1,0,0])
        sphere ( size * 2, $fn = 50 );
        
        // holow - stem
        difference ( )
        {
            scale ( 0.9 )
            difference ( ) {
                intersection ( )
                {
                    translate ( [ 0,0, size /3])
                    cube ( size, center = true );
                    intersection_for ( i = [0:3] )
                    {
                        rotate ( 90 * i )
                        translate ( [size/2,0])
                        sphere ( r = radius, $fn = 50);
                    }
                }
                
                translate ( [ 0,0,size*2.6])
                rotate ( 90, [1,0,0])
                sphere ( size * 2, $fn = 50 );
                    
            }
            // for easins printing
            translate ( [ 0,0,Max/sqrt(3) + size/5 ])
            IcoSphere ( Max );
            
            union ( ) {
                
                
                cube ( [button_attach_w,button_attach_d,Max], center = true );
                rotate ( 90 )
                cube ( [button_attach_w,button_attach_d,Max], center = true );
            }
        }
    }
}

module Simon ( ) {
    ofset = 2;
    squares = 20;
   
    difference ( ) {
        BModule ( );
        
        for ( i = [0:3] )
        {
            rotate ( 45 + 90 * i )
            translate ( [ofset,ofset,module_d/2 - rounding])
            cube ( squares );
        }
        rotate ( 45 )
        translate ( [0,0,-module_l / 2  / sqrt ( 2 ) + module_d/2 - rounding ] )
        cube ( module_l  / sqrt ( 2 ) , center = true );
    }
}

module Memory ( ) {
    difference ( ) {
        BModule ( );
        
    }
}

module MorseCode ( ) {
    difference ( ) {
        BModule ( );
        
    }
}

module ComplicatedWires ( ) {
    difference ( ) {
        BModule ( );
        
    }
}

module Mazes ( ) {
    difference ( ) {
        BModule ( );
        
    }
}

module Password_Button ( )
{
    button_l = 5;
    button_h = 7;
    chapher = 1;
    
    translate ( [0,-0.5] )
    rotate ( 90 )
    cylinder ( d = button_l, h = button_h, $fn = 3 );
    
    translate ( [0,0,chapher/2] )
    cube ( [ button_l + chapher, button_l + chapher, chapher], center = true );
}

module Password_Submit_Button ( )
{
    button_l = 20;
    button_h = 7;
    button_d = 10;
    chapher = 1;
    
    translate ( [0,0,button_d/2])
    cube ( [ button_l , button_h, button_d], center = true );
    
    translate ( [0,0,chapher/2] )
    cube ( [ button_l + chapher, button_h + chapher, chapher], center = true );
}

module Password ( ) {
    Dis_w = 40;
    Dis_l = 10;
    Dis_Pad = 4;
    Button_Padd = 20;
    

    difference ( ) {
        BModule ( );
        
        // Display hole
        translate ( [ 0,Dis_Pad,0 ])
        cube ( [ Dis_w, Dis_l, Max ], center = true );
        
        // Submit button
        
        translate ( [ 0,- Button_Padd, module_d/2 - module_internal_wall ])
        minkowski ( )
        {
            Password_Submit_Button ( );
            IcoSphere ( 0.3 );
        }
        
        // buttons
        
        minkowski ( )
        {
            translate ( [0,0, module_d/2 - module_internal_wall] )
            for ( i = [ -1.5:1.5] )
            {
                translate ( [Dis_w/4 * i, Dis_Pad + Dis_l])
                Password_Button ( );
                
                
                translate ( [Dis_w/4 * i, Dis_Pad - Dis_l ])
                mirror ( [0,1,0])
                Password_Button ( );
            }
            
            IcoSphere ( 0.3 );
        }
    }
    
    // suspenders for board
}

// Password ( );

// Neady Modules

module Capacitor ( ) {
    difference ( ) {
        BModule ( );
        
    }
}

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
