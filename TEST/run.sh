#!/bin/sh
set -x

../mage "identity_matrix" "identity_matrix"

../mage "product_matrix_3_3" "first_matrix:3:3" "second_matrix:3:3"
../mage "product_matrix_4_3" "first_matrix:4:3" "second_matrix:4:3"
../mage "product_matrix_4_4" "first_matrix:4:4" "second_matrix:4:4"

../mage "vector_matrix" "vector_matrix"
../mage "vector_product_matrix" "vector_matrix" "matrix"

../mage "translation_matrix" "x_translation,y_translation,z_translation"
../mage "translation_product_matrix" "x_translation,y_translation,z_translation" "matrix:4:3"

../mage "translation_matrix" "translation_matrix"
../mage "translation_product_matrix" "translation_matrix" "matrix"

../mage "scaling_matrix" "x_scaling;y_scaling;z_scaling"
../mage "scaling_product_matrix" "x_scaling;y_scaling;z_scaling" "matrix:3:3"

../mage "scaling_matrix" "scaling_matrix"
../mage "vector_scaling_product_matrix" "vector_matrix" "scaling_matrix"

../mage "x_scaling_matrix" "x_scaling_matrix"
../mage "vector_x_scaling_product_matrix" "vector_matrix" "x_scaling_matrix"

../mage "y_scaling_matrix" "y_scaling_matrix"
../mage "vector_y_scaling_product_matrix" "vector_matrix" "y_scaling_matrix"

../mage "z_scaling_matrix" "z_scaling_matrix"
../mage "vector_z_scaling_product_matrix" "vector_matrix" "z_scaling_matrix"


../mage "x_rotation_matrix" "x_rotation_matrix"
../mage "vector_x_rotation_product_matrix" "vector_matrix" "x_rotation_matrix"

../mage "y_rotation_matrix" "y_rotation_matrix"
../mage "vector_y_rotation_product_matrix" "vector_matrix" "y_rotation_matrix"

../mage "z_rotation_matrix" "z_rotation_matrix"
../mage "vector_z_rotation_product_matrix" "vector_matrix" "z_rotation_matrix"

../mage "xy_z_rotation_matrix" "x_rotation_matrix" "y_rotation_matrix" "z_rotation_matrix"
../mage --reverse "x_yz_rotation_matrix" "x_rotation_matrix" "y_rotation_matrix" "z_rotation_matrix"

../mage "vector_xy_z_rotation_product_matrix" "vector_matrix"  "x_rotation_matrix" "y_rotation_matrix" "z_rotation_matrix"
../mage --reverse "vector_xy_z_rotation_product_matrix" "vector_matrix" "x_rotation_matrix" "y_rotation_matrix" "z_rotation_matrix"

../mage "xz_y_rotation_matrix" "x_rotation_matrix" "z_rotation_matrix" "y_rotation_matrix"
../mage --reverse "x_zy_rotation_matrix" "x_rotation_matrix" "z_rotation_matrix" "y_rotation_matrix"

../mage "vector_xz_y_rotation_matrix" "vector_matrix" "x_rotation_matrix" "z_rotation_matrix" "y_rotation_matrix"
../mage --reverse "vector_x_zy_rotation_matrix" "vector_matrix" "x_rotation_matrix" "z_rotation_matrix" "y_rotation_matrix"

../mage "yx_z_rotation_matrix" "y_rotation_matrix" "x_rotation_matrix" "z_rotation_matrix"
../mage --reverse "y_xz_rotation_matrix" "y_rotation_matrix" "x_rotation_matrix" "z_rotation_matrix"

../mage "vector_yx_z_rotation_matrix" "vector_matrix" "y_rotation_matrix" "x_rotation_matrix" "z_rotation_matrix"
../mage --reverse "vector_y_xz_rotation_matrix" "vector_matrix" "y_rotation_matrix" "x_rotation_matrix" "z_rotation_matrix"

../mage "yz_x_rotation_matrix" "y_rotation_matrix" "z_rotation_matrix" "x_rotation_matrix"
../mage --reverse "y_zx_rotation_matrix" "y_rotation_matrix" "z_rotation_matrix" "x_rotation_matrix"

../mage "vector_yz_x_rotation_matrix" "vector_matrix" "y_rotation_matrix" "z_rotation_matrix" "x_rotation_matrix"
../mage --reverse "vector_y_zx_rotation_matrix" "vector_matrix" "y_rotation_matrix" "z_rotation_matrix" "x_rotation_matrix"

../mage "zx_y_rotation_matrix" "z_rotation_matrix" "x_rotation_matrix" "y_rotation_matrix"
../mage --reverse "z_xy_rotation_matrix" "z_rotation_matrix" "x_rotation_matrix" "y_rotation_matrix"

../mage "vector_zx_y_rotation_matrix" "vector_matrix" "z_rotation_matrix" "x_rotation_matrix" "y_rotation_matrix"
../mage --reverse "vector_z_xy_rotation_matrix" "vector_matrix" "z_rotation_matrix" "x_rotation_matrix" "y_rotation_matrix"

../mage "zy_x_rotationmatrix" "z_rotation_matrix" "y_rotation_matrix" "x_rotation_matrix"
../mage --reverse "z_yx_rotation_matrix" "z_rotation_matrix" "y_rotation_matrix" "x_rotation_matrix"

../mage "vector_zy_x_rotationmatrix" "vector_matrix" "z_rotation_matrix" "y_rotation_matrix" "x_rotation_matrix"
../mage --reverse "vector_z_yx_rotation_matrix" "vector_matrix" "z_rotation_matrix" "y_rotation_matrix" "x_rotation_matrix"


