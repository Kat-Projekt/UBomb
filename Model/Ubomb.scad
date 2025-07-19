// UBomb

module_l = 100;
module_d = 30;
module_indent_w = 30;
module_indent_d = 5;
module_lighit_d = 25;
module_lighit_cut = 5;
module_internal_wall = 5;

moudle_light_d_1 = 25;
moudle_light_d_2 = 10;
moudle_light_reduction = 0.7;
moudle_light_diamater = 7;

module_screw_cap_d = 5;

rounding = 2;

light_center = module_l/2 + module_indent_d - module_lighit_d/2 + rounding/2;


body_n = 3; // numer of modules on x
body_m = 2; // mods on y
body_separator_w = 5;
body_separator_d = 25;
body_shell_thick = 7;
body_shell_d = 30;

module Screw ( ) {
    cylinder (d=2,h=10,$fn = 16 );
    mirror ( [ 0,0,1] )
    cylinder (d=3,h=10,$fn = 16 );
}

// screws positioning
module SModule ( )
{
    for ( i = [0:3])
    rotate ( 90*i )
    translate ( [0,module_l/2+(module_indent_d+rounding/2)/2])
    Screw();
}

module IcoSphere ( d = rounding )
{
    union ( )
    { 
        linear_extrude ( d/sqrt(3), scale = 0 )
        square ( d, center = true );
        mirror ([0,0,1])
        linear_extrude ( d/sqrt(3), scale = 0 )
        square ( d, center = true );
    }
}

module ModuleShape ( )
{
    union ( )
    {
        // corpo centrale
        linear_extrude ( module_d, center = true )
        difference ( )
        {
            square ( module_l, center = true );
            
            // light cut out
            light_center = module_l/2 + module_indent_d - module_lighit_d/2;
            translate ( [light_center,light_center] )
            union ( )
            {
                circle ( d = module_lighit_d, $fn = 8 );
                
                translate ( [-module_lighit_d/2,0])
                square ( module_lighit_d );
                translate ( [0,-module_lighit_d/2] )
                square ( module_lighit_d );
                
                rotate ( 45, [0,0,1] )
                translate ( [-module_lighit_cut,-module_lighit_d*2])
                square ( module_lighit_d*4 );
            }
        }
        
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

// body of the module
module BModule ( )
{
    color ( "blue" )
    difference ( ) 
    {
        union ( )
        {
            minkowski ( )
            {
                ModuleShape ( );
                IcoSphere ( );
            }
            
            
            // light stand
            translate ( [light_center,light_center,-(moudle_light_d_2-module_d)/2] )
            minkowski ( )
            {
                union ( )
                {
                    diam = module_lighit_d-rounding;
                    linear_extrude ( moudle_light_d_2, scale = moudle_light_reduction )
                    circle ( d=diam, $fn = 8 );
                    rotate (180,[1,0,0])
                    cylinder (d=diam, h = moudle_light_d_1, $fn = 8 );
                }
                IcoSphere ( );
            }
            
            
        }
        
        // internal
        translate ( [0,0,-module_internal_wall/2 - rounding/2 ] )
        linear_extrude ( module_d - module_indent_d + rounding, center = true )
        offset ( -module_internal_wall, $fn = 12 )
        projection(cut = true) ModuleShape ( );
        
        // light
        translate ( [light_center,light_center,-moudle_light_diamater/2] )
        cylinder ( d=moudle_light_diamater,h = moudle_light_d_1+moudle_light_d_2, $fn = 8 );
        
        translate ( [light_center,light_center] )
        rotate ( 180+45,[0,0,1])
        rotate ( 90,[0,1,0])
        cylinder ( d=moudle_light_diamater,h = moudle_light_d_1+moudle_light_d_2, $fn = 4 );
        
        // remove bottom to make it flat 
        translate ( [0,0,-module_l-module_d/2+module_screw_cap_d])
        cube ( module_l*2,center = true );
    }
};

// bottom lid or cap
module CModule ( )
{
    color ( "red" )
    difference ( ) {
        union ( ) {
            minkowski ( )
            {
                ModuleShape ( );
                IcoSphere ( );
            }
            // light stand
            translate ( [light_center,light_center,0] )
            minkowski ( )
            {
                diam = module_lighit_d-rounding;
                cylinder (d=diam, h = module_d, $fn = 8, center = true );
                IcoSphere ( );
            }
        }
        
        // remove top to make it flat 
        translate ( [0,0,module_l-module_d/2+module_screw_cap_d])
        cube ( module_l*2,center = true );
    }
}

clip_diametro = 3;
clip_spessore = 0.62;
clip_lunghezz = 15;

clip_attach_h = 1.2;
clip_attach_d = 6;
clip_attach_w = 5;

module PClip ( ) {
    circle ( d = clip_diametro, $fn = 20 );
    translate ( [0,-clip_lunghezz/2] )
    square ( [clip_diametro,clip_lunghezz], center = true );
    
    translate ( [ clip_diametro/2, -clip_attach_d-clip_attach_w] )
    polygon ( [
        [0,0],
        [0,clip_attach_w],
        [clip_attach_h,clip_attach_w-clip_attach_h],
        [clip_attach_h,clip_attach_h]
    ] );
    
}

module Clip ( thick = 1 )
{
    rotate ( 90,[1,0,0] )
    difference ( )
    {
        translate ( [clip_diametro/2-clip_spessore,0] ) 
        linear_extrude ( thick )
        difference ( ) 
        {
            PClip ( );
            
            offset ( -clip_spessore, $fn = 20 )
            PClip ( );
            
            // bottom joint
            translate ( [0,-clip_lunghezz])
            square ( clip_diametro, center = true );
            
        }
        // bottom smoothing
        
        for ( i = [0,1] )
        {
            translate ( [0,0,thick*i])
            translate ( [0,-clip_lunghezz+clip_diametro/2] )
            rotate ( - 90 - 90 * i, [1,0,0])
            rotate ( 90, [0,1,0])
            translate ( [-clip_diametro,-clip_diametro]/2 )
            difference ( ) 
            {
                cube ( clip_diametro );
                cylinder ( d = clip_diametro, h = clip_diametro,$fn = 12 );
            }
        }
    }
}

normal_clip_w = 30;
small_clip_w = 10;
clip_pading = 5;
tollerance = 0.3;

// with tollence
larghezza_modulo = module_l + module_indent_d*2 + rounding + tollerance*2;

module Separator ( segments, vertical_cut = 1 )
{
    lungezza = ( larghezza_modulo ) * segments + body_separator_w * ( segments - 1 );
    difference ( )
    {
        union ( )
        {
            minkowski ( ) {
                translate ( [0,1/2,1/sqrt(3)]*rounding )
                cube ( [ body_separator_w-rounding/2, lungezza-rounding, body_separator_d -rounding * 2 / sqrt(3) ] );
                IcoSphere ( );
            }
        
            // clips 
            for ( i = [1:segments] )
            {
                translate ( [ 0,
                    larghezza_modulo*i+ body_separator_w * ( i - 1 ),
                    body_separator_d
                ] )
                union ( )
                {   
                    translate ( [0,-clip_pading] )
                    {
                        mirror ( [1,0,0] )
                        Clip ( normal_clip_w );
                        
                        translate ( [body_separator_w,0] )
                        Clip ( normal_clip_w );
                    }
                    
                    translate ( [0,-larghezza_modulo+clip_pading+normal_clip_w] )
                    {
                        mirror ( [1,0,0] )
                        Clip ( normal_clip_w );
                        
                        
                        translate ( [body_separator_w,0] )
                        Clip ( small_clip_w );
                    }
                }
            }
        }
        
        
        // cuts
        for ( i = [0:segments] )
        {
            translate ( [-body_separator_w/2,
                larghezza_modulo * i + body_separator_w * ( i - 1 ),
                ( vertical_cut * body_separator_d / 2 )
            ] )
            cube ( [body_separator_w*2,body_separator_w, body_separator_d / 2 ]);
        }
    }
}

module Box ( n,m )
{   
    difference ( )
    {
        minkowski ( )
        {
            difference ( )
            {
                cube ( [ 
                    larghezza_modulo * n + body_separator_w * ( n - 1 ) + body_shell_thick * 2,
                    larghezza_modulo * m + body_separator_w * ( m - 1 ) + body_shell_thick * 2,
                    body_shell_d ]
                );
                translate ( [body_shell_thick,body_shell_thick,body_shell_thick])
                cube ( [ 
                    larghezza_modulo * n + body_separator_w * ( n - 1 ),
                    larghezza_modulo * m + body_separator_w * ( m - 1 ),
                    body_shell_d ]
                );
            }
            IcoSphere ( );
        }
        translate ( [-1,-1]*body_shell_thick/2)
        mirror ( [ 0,0,1 ] )
        cube ( [ 
            larghezza_modulo * n + body_separator_w * ( n - 1 ) + body_shell_thick * 3,
            larghezza_modulo * m + body_separator_w * ( m - 1 ) + body_shell_thick * 3,
            body_shell_d ]
        );
    }
    
}

// Box ( 2,3 );

// Separator ( 3 );

// translate ( [-1,1,0] * (module_l/2+module_indent_d+rounding/2 + tollerance) )
// BModule ( );


difference ( )
{
    translate ( [0,0,body_shell_d/2])
    CModule ( );
    SModule ( );
}

