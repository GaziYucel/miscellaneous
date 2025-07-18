<?php

// add custom fonts
function salient_redux_custom_fonts( $custom_fonts ) {
    return array(
        'Custom Fonts' => array(
             'Open Sans' => "Open Sans 1",
             'Amatic SC' => "Amatic SC",
             'Indie Flower' => "Indie Flower" 
        )
    );
}
add_filter( "redux/salient_redux/field/typography/custom_fonts", "salient_redux_custom_fonts" );

