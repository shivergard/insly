<?php

/**
     ☐ outputs an <ul> list of all integers in the range of 1-100
     ☐ in place of all numbers that are divisible by 3, outputs string “foo” instead
     ☐ in place of all numbers that are divisible by 5, outputs string “bar” instead
     ☐ for numbers that are divisible by both 3 and 5, outputs string “foobar” instead
 */

$return = array();

for ( $i = 1; $i <= 100; ++$i )
{
     $str = "";
 
     if (!($i % 3 ) )
          $str .= "foo";
 
     if (!($i % 5 ) )
          $str .= "bar";
 
     if ( empty( $str ) )
          $str = $i;
 
     $return[] = $str;
}

echo '<ul><li>'.implode("</li>\n<li>" , $return).'</li></ul>';