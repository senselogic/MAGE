/*
    This file is part of the Mage distribution.

    https://github.com/senselogic/MAGE

    Copyright (C) 2017 Eric Pelzer (ecstatic.coder@gmail.com)

    Mage is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, version 3.

    Mage is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with Mage.  If not, see <http://www.gnu.org/licenses/>.
*/

// -- IMPORTS

import std.conv : to;
import std.regex : matchFirst, regex, Captures, Regex;
import std.stdio : writeln;
import std.string : indexOf, split, startsWith, strip;

// -- TYPES

struct MATRIX
{
    // -- CONSTANTS

    enum
    {
        XVectorIndex = 0,
        YVectorIndex = 1,
        ZVectorIndex = 2,
        WVectorIndex = 3,
        VectorCount = 4,
        XComponentIndex = 0,
        YComponentIndex = 1,
        ZComponentIndex = 2,
        WComponentIndex = 3,
        ComponentCount = 4
    };

    // -- ATTRIBUTES

    string[ 4 ][ 4 ]
        ComponentArray;

    // -- INQUIRIES

    bool IsSumComponent(
        string component
        )
    {
        return
            component.indexOf( " - " ) >= 0
            || component.indexOf( " + " ) >= 0;
    }

    // -- OPERATIONS

    void SetIdentity(
        )
    {
        ComponentArray[ XVectorIndex ][ XComponentIndex ] = "1.0";
        ComponentArray[ XVectorIndex ][ YComponentIndex ] = "0.0";
        ComponentArray[ XVectorIndex ][ ZComponentIndex ] = "0.0";
        ComponentArray[ XVectorIndex ][ WComponentIndex ] = "0.0";

        ComponentArray[ YVectorIndex ][ XComponentIndex ] = "0.0";
        ComponentArray[ YVectorIndex ][ YComponentIndex ] = "1.0";
        ComponentArray[ YVectorIndex ][ ZComponentIndex ] = "0.0";
        ComponentArray[ YVectorIndex ][ WComponentIndex ] = "0.0";

        ComponentArray[ ZVectorIndex ][ XComponentIndex ] = "0.0";
        ComponentArray[ ZVectorIndex ][ YComponentIndex ] = "0.0";
        ComponentArray[ ZVectorIndex ][ ZComponentIndex ] = "1.0";
        ComponentArray[ ZVectorIndex ][ WComponentIndex ] = "0.0";

        ComponentArray[ WVectorIndex ][ XComponentIndex ] = "0.0";
        ComponentArray[ WVectorIndex ][ YComponentIndex ] = "0.0";
        ComponentArray[ WVectorIndex ][ ZComponentIndex ] = "0.0";
        ComponentArray[ WVectorIndex ][ WComponentIndex ] = "1.0";
    }

    // ~~

    void SetQuaternion(
        )
    {
        ComponentArray[ XVectorIndex ][ XComponentIndex ] = "1.0 - 2.0 * quaternion_y * quaternion_y - 2.0 * quaternion_z * quaternion_z";
        ComponentArray[ XVectorIndex ][ YComponentIndex ] = "2.0 * quaternion_x * quaternion_y + 2.0 * quaternion_w * quaternion_z";
        ComponentArray[ XVectorIndex ][ ZComponentIndex ] = "2.0 * quaternion_x * quaternion_z - 2.0 * quaternion_w * quaternion_y";
        ComponentArray[ XVectorIndex ][ WComponentIndex ] = "0.0";

        ComponentArray[ YVectorIndex ][ XComponentIndex ] = "2.0 * quaternion_x * quaternion_y - 2.0 * quaternion_w * quaternion_z";
        ComponentArray[ YVectorIndex ][ YComponentIndex ] = "1.0 - 2.0 * quaternion_x * quaternion_x - 2.0 * quaternion_z * quaternion_z";
        ComponentArray[ YVectorIndex ][ ZComponentIndex ] = "2.0 * quaternion_y * quaternion_z + 2.0 * quaternion_w * quaternion_x";
        ComponentArray[ YVectorIndex ][ WComponentIndex ] = "0.0";

        ComponentArray[ ZVectorIndex ][ XComponentIndex ] = "2.0 * quaternion_x * quaternion_z + 2.0 * quaternion_w * quaternion_y";
        ComponentArray[ ZVectorIndex ][ YComponentIndex ] = "2.0 * quaternion_y * quaternion_z - 2.0 * quaternion_w * quaternion_x";
        ComponentArray[ ZVectorIndex ][ ZComponentIndex ] = "1.0 - 2.0 * quaternion_x * quaternion_x - 2.0 * quaternion_y * quaternion_y";
        ComponentArray[ ZVectorIndex ][ WComponentIndex ] = "0.0";

        ComponentArray[ WVectorIndex ][ XComponentIndex ] = "0.0";
        ComponentArray[ WVectorIndex ][ YComponentIndex ] = "0.0";
        ComponentArray[ WVectorIndex ][ ZComponentIndex ] = "0.0";
        ComponentArray[ WVectorIndex ][ WComponentIndex ] = "1.0";
    }

    // ~~

    void SetFromVector(
        string w_vector_x_component,
        string w_vector_y_component,
        string w_vector_z_component
        )
    {
        ComponentArray[ XVectorIndex ][ XComponentIndex ] = "1.0";
        ComponentArray[ XVectorIndex ][ YComponentIndex ] = "0.0";
        ComponentArray[ XVectorIndex ][ ZComponentIndex ] = "0.0";
        ComponentArray[ XVectorIndex ][ WComponentIndex ] = "0.0";

        ComponentArray[ YVectorIndex ][ XComponentIndex ] = "0.0";
        ComponentArray[ YVectorIndex ][ YComponentIndex ] = "1.0";
        ComponentArray[ YVectorIndex ][ ZComponentIndex ] = "0.0";
        ComponentArray[ YVectorIndex ][ WComponentIndex ] = "0.0";

        ComponentArray[ ZVectorIndex ][ XComponentIndex ] = "0.0";
        ComponentArray[ ZVectorIndex ][ YComponentIndex ] = "0.0";
        ComponentArray[ ZVectorIndex ][ ZComponentIndex ] = "1.0";
        ComponentArray[ ZVectorIndex ][ WComponentIndex ] = "0.0";

        ComponentArray[ WVectorIndex ][ XComponentIndex ] = w_vector_x_component;
        ComponentArray[ WVectorIndex ][ YComponentIndex ] = w_vector_y_component;
        ComponentArray[ WVectorIndex ][ ZComponentIndex ] = w_vector_z_component;
        ComponentArray[ WVectorIndex ][ WComponentIndex ] = "1.0";
    }

    // ~~

    void SetFromComponents(
        string x_vector_x_component,
        string y_vector_y_component,
        string z_vector_z_component
        )
    {
        ComponentArray[ XVectorIndex ][ XComponentIndex ] = x_vector_x_component;
        ComponentArray[ XVectorIndex ][ YComponentIndex ] = "0.0";
        ComponentArray[ XVectorIndex ][ ZComponentIndex ] = "0.0";
        ComponentArray[ XVectorIndex ][ WComponentIndex ] = "0.0";

        ComponentArray[ YVectorIndex ][ XComponentIndex ] = "0.0";
        ComponentArray[ YVectorIndex ][ YComponentIndex ] = y_vector_y_component;
        ComponentArray[ YVectorIndex ][ ZComponentIndex ] = "0.0";
        ComponentArray[ YVectorIndex ][ WComponentIndex ] = "0.0";

        ComponentArray[ ZVectorIndex ][ XComponentIndex ] = "0.0";
        ComponentArray[ ZVectorIndex ][ YComponentIndex ] = "0.0";
        ComponentArray[ ZVectorIndex ][ ZComponentIndex ] = z_vector_z_component;
        ComponentArray[ ZVectorIndex ][ WComponentIndex ] = "0.0";

        ComponentArray[ WVectorIndex ][ XComponentIndex ] = "0.0";
        ComponentArray[ WVectorIndex ][ YComponentIndex ] = "0.0";
        ComponentArray[ WVectorIndex ][ ZComponentIndex ] = "0.0";
        ComponentArray[ WVectorIndex ][ WComponentIndex ] = "1.0";
    }

    // ~~

    void SetFromComponents(
        string x_vector_x_component,
        string y_vector_y_component,
        string z_vector_z_component,
        string w_vector_x_component,
        string w_vector_y_component,
        string w_vector_z_component
        )
    {

        ComponentArray[ XVectorIndex ][ XComponentIndex ] = x_vector_x_component;
        ComponentArray[ XVectorIndex ][ YComponentIndex ] = "0.0";
        ComponentArray[ XVectorIndex ][ ZComponentIndex ] = "0.0";
        ComponentArray[ XVectorIndex ][ WComponentIndex ] = "0.0";

        ComponentArray[ YVectorIndex ][ XComponentIndex ] = "0.0";
        ComponentArray[ YVectorIndex ][ YComponentIndex ] = y_vector_y_component;
        ComponentArray[ YVectorIndex ][ ZComponentIndex ] = "0.0";
        ComponentArray[ YVectorIndex ][ WComponentIndex ] = "0.0";

        ComponentArray[ ZVectorIndex ][ XComponentIndex ] = "0.0";
        ComponentArray[ ZVectorIndex ][ YComponentIndex ] = "0.0";
        ComponentArray[ ZVectorIndex ][ ZComponentIndex ] = z_vector_z_component;
        ComponentArray[ ZVectorIndex ][ WComponentIndex ] = "0.0";

        ComponentArray[ WVectorIndex ][ XComponentIndex ] = w_vector_x_component;
        ComponentArray[ WVectorIndex ][ YComponentIndex ] = w_vector_y_component;
        ComponentArray[ WVectorIndex ][ ZComponentIndex ] = w_vector_z_component;
        ComponentArray[ WVectorIndex ][ WComponentIndex ] = "1.0";
    }

    // ~~

    void SetFromComponents(
        string x_vector_x_component,
        string x_vector_y_component,
        string x_vector_z_component,
        string y_vector_x_component,
        string y_vector_y_component,
        string y_vector_z_component,
        string z_vector_x_component,
        string z_vector_y_component,
        string z_vector_z_component
        )
    {
        ComponentArray[ XVectorIndex ][ XComponentIndex ] = x_vector_x_component;
        ComponentArray[ XVectorIndex ][ YComponentIndex ] = x_vector_y_component;
        ComponentArray[ XVectorIndex ][ ZComponentIndex ] = x_vector_z_component;
        ComponentArray[ XVectorIndex ][ WComponentIndex ] = "0.0";

        ComponentArray[ YVectorIndex ][ XComponentIndex ] = y_vector_x_component;
        ComponentArray[ YVectorIndex ][ YComponentIndex ] = y_vector_y_component;
        ComponentArray[ YVectorIndex ][ ZComponentIndex ] = y_vector_z_component;
        ComponentArray[ YVectorIndex ][ WComponentIndex ] = "0.0";

        ComponentArray[ ZVectorIndex ][ XComponentIndex ] = z_vector_x_component;
        ComponentArray[ ZVectorIndex ][ YComponentIndex ] = z_vector_y_component;
        ComponentArray[ ZVectorIndex ][ ZComponentIndex ] = z_vector_z_component;
        ComponentArray[ ZVectorIndex ][ WComponentIndex ] = "0.0";

        ComponentArray[ WVectorIndex ][ XComponentIndex ] = "0.0";
        ComponentArray[ WVectorIndex ][ YComponentIndex ] = "0.0";
        ComponentArray[ WVectorIndex ][ ZComponentIndex ] = "0.0";
        ComponentArray[ WVectorIndex ][ WComponentIndex ] = "1.0";
    }

    // ~~

    void SetFromComponents(
        string x_vector_x_component,
        string x_vector_y_component,
        string x_vector_z_component,
        string y_vector_x_component,
        string y_vector_y_component,
        string y_vector_z_component,
        string z_vector_x_component,
        string z_vector_y_component,
        string z_vector_z_component,
        string w_vector_x_component,
        string w_vector_y_component,
        string w_vector_z_component
        )
    {
        ComponentArray[ XVectorIndex ][ XComponentIndex ] = x_vector_x_component;
        ComponentArray[ XVectorIndex ][ YComponentIndex ] = x_vector_y_component;
        ComponentArray[ XVectorIndex ][ ZComponentIndex ] = x_vector_z_component;
        ComponentArray[ XVectorIndex ][ WComponentIndex ] = "0.0";

        ComponentArray[ YVectorIndex ][ XComponentIndex ] = y_vector_x_component;
        ComponentArray[ YVectorIndex ][ YComponentIndex ] = y_vector_y_component;
        ComponentArray[ YVectorIndex ][ ZComponentIndex ] = y_vector_z_component;
        ComponentArray[ YVectorIndex ][ WComponentIndex ] = "0.0";

        ComponentArray[ ZVectorIndex ][ XComponentIndex ] = z_vector_x_component;
        ComponentArray[ ZVectorIndex ][ YComponentIndex ] = z_vector_y_component;
        ComponentArray[ ZVectorIndex ][ ZComponentIndex ] = z_vector_z_component;
        ComponentArray[ ZVectorIndex ][ WComponentIndex ] = "0.0";

        ComponentArray[ WVectorIndex ][ XComponentIndex ] = w_vector_x_component;
        ComponentArray[ WVectorIndex ][ YComponentIndex ] = w_vector_y_component;
        ComponentArray[ WVectorIndex ][ ZComponentIndex ] = w_vector_z_component;
        ComponentArray[ WVectorIndex ][ WComponentIndex ] = "1.0";
    }

    // ~~

    void SetFromComponents(
        string x_vector_x_component,
        string x_vector_y_component,
        string x_vector_z_component,
        string x_vector_w_component,
        string y_vector_x_component,
        string y_vector_y_component,
        string y_vector_z_component,
        string y_vector_w_component,
        string z_vector_x_component,
        string z_vector_y_component,
        string z_vector_z_component,
        string z_vector_w_component,
        string w_vector_x_component,
        string w_vector_y_component,
        string w_vector_z_component,
        string w_vector_w_component
        )
    {
        ComponentArray[ XVectorIndex ][ XComponentIndex ] = x_vector_x_component;
        ComponentArray[ XVectorIndex ][ YComponentIndex ] = x_vector_y_component;
        ComponentArray[ XVectorIndex ][ ZComponentIndex ] = x_vector_z_component;
        ComponentArray[ XVectorIndex ][ WComponentIndex ] = x_vector_w_component;

        ComponentArray[ YVectorIndex ][ XComponentIndex ] = y_vector_x_component;
        ComponentArray[ YVectorIndex ][ YComponentIndex ] = y_vector_y_component;
        ComponentArray[ YVectorIndex ][ ZComponentIndex ] = y_vector_z_component;
        ComponentArray[ YVectorIndex ][ WComponentIndex ] = y_vector_w_component;

        ComponentArray[ ZVectorIndex ][ XComponentIndex ] = z_vector_x_component;
        ComponentArray[ ZVectorIndex ][ YComponentIndex ] = z_vector_y_component;
        ComponentArray[ ZVectorIndex ][ ZComponentIndex ] = z_vector_z_component;
        ComponentArray[ ZVectorIndex ][ WComponentIndex ] = z_vector_w_component;

        ComponentArray[ WVectorIndex ][ XComponentIndex ] = w_vector_x_component;
        ComponentArray[ WVectorIndex ][ YComponentIndex ] = w_vector_y_component;
        ComponentArray[ WVectorIndex ][ ZComponentIndex ] = w_vector_z_component;
        ComponentArray[ WVectorIndex ][ WComponentIndex ] = w_vector_w_component;
    }

    // ~~

    void SetFromXRotation(
        string x_cosinus,
        string x_sinus
        )
    {
        string
            minus_x_sinus;

        // Turn Y axis towards Z axis.

        SetIdentity();

        minus_x_sinus = "-" ~ x_sinus;

        ComponentArray[ YVectorIndex ][ YComponentIndex ] = x_cosinus;
        ComponentArray[ YVectorIndex ][ ZComponentIndex ] = x_sinus;

        ComponentArray[ ZVectorIndex ][ YComponentIndex ] = minus_x_sinus;
        ComponentArray[ ZVectorIndex ][ ZComponentIndex ] = x_cosinus;
    }

    // ~~

    void SetFromYRotation(
        string y_cosinus,
        string y_sinus
        )
    {
        string
            minus_y_sinus;

        // Turn Z axis towards X axis.

        SetIdentity();

        minus_y_sinus = "-" ~ y_sinus;

        ComponentArray[ ZVectorIndex ][ ZComponentIndex ] = y_cosinus;
        ComponentArray[ ZVectorIndex ][ XComponentIndex ] = y_sinus;

        ComponentArray[ XVectorIndex ][ ZComponentIndex ] = minus_y_sinus;
        ComponentArray[ XVectorIndex ][ XComponentIndex ] = y_cosinus;
    }

    // ~~

    void SetFromZRotation(
        string z_cosinus,
        string z_sinus
        )
    {
        string
            minus_z_sinus;

        // Turn X axis towards Y axis.

        SetIdentity();

        minus_z_sinus = "-" ~ z_sinus;

        ComponentArray[ XVectorIndex ][ XComponentIndex ] = z_cosinus;
        ComponentArray[ XVectorIndex ][ YComponentIndex ] = z_sinus;

        ComponentArray[ YVectorIndex ][ XComponentIndex ] = minus_z_sinus;
        ComponentArray[ YVectorIndex ][ YComponentIndex ] = z_cosinus;
    }

    // ~~

    void SetFromName(
        string name,
        long vector_count,
        long component_count
        )
    {
        SetIdentity();

        foreach ( vector_index; 0 .. vector_count )
        {
            foreach ( component_index; 0 .. component_count )
            {
                ComponentArray[ vector_index ][ component_index ]
                    = name ~ "." ~ "XYZW"[ vector_index ] ~ "Vector." ~ "XYZW"[ component_index ];
            }
        }
    }

    // ~~

    void SetProductMatrix(
        MATRIX first_matrix,
        MATRIX second_matrix
        )
    {
        long
            first_vector_index,
            second_component_index,
            second_vector_index;
        string
            component,
            term_component,
            first_component,
            second_component;

        foreach ( vector_index; 0 .. VectorCount )
        {
            foreach ( component_index; 0 .. ComponentCount )
            {
                component = ComponentArray[ vector_index ][ component_index ];
                component = "0.0";
                first_vector_index = vector_index;
                second_component_index = component_index;

                foreach ( first_component_index; 0 .. ComponentCount )
                {
                    second_vector_index = first_component_index;
                    first_component = first_matrix.ComponentArray[ first_vector_index ][ first_component_index ];
                    second_component = second_matrix.ComponentArray[ second_vector_index ][ second_component_index ];

                    if ( first_component == "0.0" || second_component == "0.0" )
                    {
                        term_component = "0.0";
                    }
                    else if ( first_component == "1.0" )
                    {
                        term_component = second_component;
                    }
                    else if ( second_component == "1.0" )
                    {
                        term_component = first_component;
                    }
                    else
                    {
                        if ( IsSumComponent( first_component ) )
                        {
                            first_component = "( " ~ first_component ~ " )";
                        }

                        if ( IsSumComponent( second_component ) )
                        {
                            second_component = "( " ~ second_component ~ " )";
                        }

                        term_component = first_component ~ " * " ~ second_component;
                    }

                    if ( component == "0.0" )
                    {
                        component = term_component;
                    }
                    else if ( term_component != "0.0" )
                    {
                        component = component ~ " + " ~ term_component;
                    }
                }

                ComponentArray[ vector_index ][ component_index ] = component;
            }
        }
    }

    // ~~

    bool FindMatch(
        string text,
        Regex!char expression,
        ref Captures!( string ) match
        )
    {
        match = text.matchFirst( expression );

        return !match.empty();
    }

    // ~~

    string GetFixedExpression(
        string expression
        )
    {
        string
            old_expression;
        Captures!( string )
            match;
        Regex!char
            negative_addition_expression,
            negative_product_expression,
            positive_product_expression,
            positive_substraction_expression;

        negative_addition_expression = regex( `(.+)\+ -([A-Za-z0-9_\.]+.*)` );
        positive_substraction_expression = regex( `(.+)\- -([A-Za-z0-9_\.]+.*)` );
        negative_product_expression = regex( `(.+) ([A-Za-z0-9_\.]+) \* -([A-Za-z0-9_\.]+.*)` );
        positive_product_expression = regex( `(.+) -([A-Za-z0-9_\.]+) \* -([A-Za-z0-9_\.]+.*)` );

        do
        {
            old_expression = expression;

            if ( FindMatch( expression, negative_addition_expression, match ) )
            {
                expression = match[ 1 ] ~ "- " ~ match[ 2 ];
            }
            else if ( FindMatch( expression, positive_substraction_expression, match ) )
            {
                expression = match[ 1 ] ~ "+ " ~ match[ 2 ];
            }
            else if ( FindMatch( expression, negative_product_expression, match ) )
            {
                expression = match[ 1 ] ~ " -" ~ match[ 2 ] ~ " * " ~ match[ 3 ];
            }
            else if ( FindMatch( expression, positive_product_expression, match ) )
            {
                expression = match[ 1 ] ~ " " ~ match[ 2 ] ~ " * " ~ match[ 3 ];
            }
        }
        while ( expression != old_expression );

        return expression;
    }

    // ~~

    void Print(
        string name
        )
    {
        string
            expression;

        foreach ( vector_index; 0 .. VectorCount )
        {
            foreach ( component_index; 0 .. ComponentCount )
            {
                expression
                    = name
                      ~ '.'
                      ~ "XYZW"[ vector_index ]
                      ~ "Vector."
                      ~ "XYZW"[ component_index ]
                      ~ " = "
                      ~ ComponentArray[ vector_index ][ component_index ]
                      ~ ";";

                writeln( GetFixedExpression( expression ) );
            }

            writeln();
        }

        writeln();
    }

};

// -- FUNCTIONS

void main(
    string[] argument_array
    )
{
    bool
        reverse_option_is_enabled;
    long
        component_count,
        matrix_index,
        vector_count;
    string
        argument,
        matrix_name,
        option;
    string[]
        value_array;
    MATRIX
        first_matrix,
        matrix,
        product_matrix,
        second_matrix;
    MATRIX[]
        matrix_array;

    reverse_option_is_enabled = false;

    argument_array = argument_array[ 1 .. $ ];

    while ( argument_array.length >= 1
            && argument_array[ 0 ].startsWith( "--" ) )
    {
        option = argument_array[ 0 ];

        argument_array = argument_array[ 1 .. $ ];

        if ( option == "--reverse" )
        {
            reverse_option_is_enabled = true;
        }
    }

    if ( argument_array.length >= 2 )
    {
        matrix_name = argument_array[ 0 ];
        matrix_array.length = argument_array.length.to!long() - 1;

        foreach ( argument_index; 1 .. argument_array.length )
        {
            argument = argument_array[ argument_index ];

            if ( argument == "identity_matrix" )
            {
                matrix.SetIdentity();
            }
            else if ( argument == "quaternion_matrix" )
            {
                matrix.SetQuaternion();
            }
            else if ( argument == "vector_matrix" )
            {
                matrix.SetFromVector( "vector.X", "vector.Y", "vector.Z" );
            }
            else if ( argument == "translation_matrix" )
            {
                matrix.SetFromVector( "x_translation", "y_translation", "z_translation" );
            }
            else if ( argument == "scaling_matrix" )
            {
                matrix.SetFromComponents( "x_scaling", "y_scaling", "z_scaling" );
            }
            else if ( argument == "x_scaling_matrix" )
            {
                matrix.SetFromComponents( "x_scaling", "1.0", "1.0" );
            }
            else if ( argument == "y_scaling_matrix" )
            {
                matrix.SetFromComponents( "1.0", "y_scaling", "1.0" );
            }
            else if ( argument == "z_scaling_matrix" )
            {
                matrix.SetFromComponents( "1.0", "1.0", "z_scaling" );
            }
            else if ( argument == "x_rotation_matrix" )
            {
                matrix.SetFromXRotation( "x_cosinus", "x_sinus" );
            }
            else if ( argument == "y_rotation_matrix" )
            {
                matrix.SetFromYRotation( "y_cosinus", "y_sinus" );
            }
            else if ( argument == "z_rotation_matrix" )
            {
                matrix.SetFromZRotation( "z_cosinus", "z_sinus" );
            }
            else if ( argument.indexOf( ',' ) > 0 )
            {
                value_array = argument.split( "," );

                if ( value_array.length == 3 )
                {
                    matrix.SetFromVector(
                        value_array[ 0 ].strip(),
                        value_array[ 1 ].strip(),
                        value_array[ 2 ].strip()
                        );
                }
                else
                {
                    writeln( "Bad argument : ", argument );

                    return;
                }
            }
            else if ( argument.indexOf( ';' ) > 0 )
            {
                value_array = argument.split( ";" );

                if ( value_array.length == 3 )
                {
                    matrix.SetFromComponents(
                        value_array[ 0 ].strip(),
                        value_array[ 1 ].strip(),
                        value_array[ 2 ].strip()
                        );
                }
                else if ( value_array.length == 6 )
                {
                    matrix.SetFromComponents(
                        value_array[ 0 ].strip(),
                        value_array[ 1 ].strip(),
                        value_array[ 2 ].strip(),
                        value_array[ 3 ].strip(),
                        value_array[ 4 ].strip(),
                        value_array[ 5 ].strip()
                        );
                }
                else if ( value_array.length == 9 )
                {
                    matrix.SetFromComponents(
                        value_array[ 0 ].strip(),
                        value_array[ 1 ].strip(),
                        value_array[ 2 ].strip(),
                        value_array[ 3 ].strip(),
                        value_array[ 4 ].strip(),
                        value_array[ 5 ].strip(),
                        value_array[ 6 ].strip(),
                        value_array[ 7 ].strip(),
                        value_array[ 8 ].strip()
                        );
                }
                else if ( value_array.length == 12 )
                {
                    matrix.SetFromComponents(
                        value_array[ 0 ].strip(),
                        value_array[ 1 ].strip(),
                        value_array[ 2 ].strip(),
                        value_array[ 3 ].strip(),
                        value_array[ 4 ].strip(),
                        value_array[ 5 ].strip(),
                        value_array[ 6 ].strip(),
                        value_array[ 7 ].strip(),
                        value_array[ 8 ].strip(),
                        value_array[ 9 ].strip(),
                        value_array[ 10 ].strip(),
                        value_array[ 11 ].strip()
                        );
                }
                else if ( value_array.length == 16 )
                {
                    matrix.SetFromComponents(
                        value_array[ 0 ].strip(),
                        value_array[ 1 ].strip(),
                        value_array[ 2 ].strip(),
                        value_array[ 3 ].strip(),
                        value_array[ 4 ].strip(),
                        value_array[ 5 ].strip(),
                        value_array[ 6 ].strip(),
                        value_array[ 7 ].strip(),
                        value_array[ 8 ].strip(),
                        value_array[ 9 ].strip(),
                        value_array[ 10 ].strip(),
                        value_array[ 11 ].strip(),
                        value_array[ 12 ].strip(),
                        value_array[ 13 ].strip(),
                        value_array[ 14 ].strip(),
                        value_array[ 15 ].strip()
                        );
                }
                else
                {
                    writeln( "Bad argument : ", argument );

                    return;
                }
            }
            else
            {
                value_array = argument.split( ":" );

                if ( value_array.length > 1 )
                {
                    vector_count = value_array[ 1 ].to!long();
                }
                else
                {
                    vector_count = 4;
                }

                if ( value_array.length > 2 )
                {
                    component_count = value_array[ 2 ].to!long();
                }
                else
                {
                    component_count = vector_count;
                }

                matrix.SetFromName( value_array[ 0 ], vector_count, component_count );
            }

            matrix_array[ argument_index - 1 ] = matrix;
        }

        if ( !reverse_option_is_enabled )
        {
            product_matrix = matrix_array[ 0 ];

            for ( matrix_index = 1;
                  matrix_index < matrix_array.length;
                  ++matrix_index )
            {
                first_matrix = product_matrix;
                second_matrix = matrix_array[ matrix_index ];

                product_matrix.SetProductMatrix( first_matrix, second_matrix );
            }
        }
        else
        {
            product_matrix = matrix_array[ matrix_array.length.to!long() - 1 ];

            for ( matrix_index = matrix_array.length.to!long() - 2;
                  matrix_index >= 0;
                  --matrix_index )
            {
                first_matrix = matrix_array[ matrix_index ];
                second_matrix = product_matrix;

                product_matrix.SetProductMatrix( first_matrix, second_matrix );
            }
        }

        product_matrix.Print( matrix_name );
    }
    else
    {
        writeln( "Usage : mage [options] first_matrix second_matrix ..." );
        writeln( "Options :" );
        writeln( "    --reverse" );

        writeln( "Invalid arguments : ", argument_array );
    }
}

























