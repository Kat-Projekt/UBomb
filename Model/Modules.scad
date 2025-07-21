include <Ubomb.scad>

// Normal Modules

module Wires ( ) {
    difference ( ) {
        BModule ( );
        
    }
}

module Button ( ) {
    difference ( ) {
        BModule ( );
        
    }
}

module KeyPads ( ) {
    difference ( ) {
        BModule ( );
        
    }
}

module Simon ( ) {
    ofset = 2;
    difference ( ) {
        BModule ( );
        
        for ( i = [0:3] )
        {
            rotate ( 45 + 90 * i )
            translate ( [ofset,ofset])
            cube ( module_l / 2 / sqrt ( 2 ) * 0.9 );
        }
        rotate ( 45 )
        translate ( [0,0,-module_l / 2  / sqrt ( 2 ) + module_d/2] )
        cube ( module_l  / sqrt ( 2 ) , center = true );
    }
}
Simon ( );

module WhosOn ( ) {
    difference ( ) {
        BModule ( );
        
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

module Password ( ) {
    difference ( ) {
        BModule ( );
        
    }
}

// Neady Modules

module VentingGase ( ) {
    difference ( ) {
        BModule ( );
        
    }
}

module Capacitor ( ) {
    difference ( ) {
        BModule ( );
        
    }
}

module Knobs ( ) {
    difference ( ) {
        BModule ( );
        
    }
}


