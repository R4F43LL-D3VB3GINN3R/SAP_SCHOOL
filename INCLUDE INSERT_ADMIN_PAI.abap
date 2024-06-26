*----------------------------------------------------------------------*
***INCLUDE Z_AFTER_INSERT_ADMIN.
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  AFTER_INSERT_PAI  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE after_insert_pai INPUT.

  "DATA: in_nickname   TYPE zlogin, "Admin Login
        "in_password   TYPE zpass,  "Admin Pass
        "in_lvl_access TYPE zlvl.   "Admin lvl

  CASE okcode0021.         "Case button is pressed...
    WHEN 'FCT_INSERT0021'. "When the Button Insert is pressed...

        "Strings are lower case in the Database
        TRANSLATE in_nickname TO LOWER CASE.
        TRANSLATE in_password  TO LOWER CASE.

      TRY.
        cl_admin->insert_admin(
          IMPORTING
            login_adm = in_nickname   "nickname on the screen
            pass_adm  = in_password   "password on the screen
            lvl       = in_lvl_access "lvl access on the screen
        ).
        MESSAGE 'Admin inserted successfully' TYPE 'S'.
      CATCH cx_application_error INTO DATA(lx_error).
        MESSAGE lx_error->error_message TYPE 'E'.
      CATCH cx_static_check INTO DATA(lx_static).
        MESSAGE 'Admin inserted failed' TYPE 'E'.
      CATCH cx_root INTO DATA(lx_root).
        MESSAGE lx_root->get_text( ) TYPE 'E'.
      ENDTRY.

    WHEN 'FCT_BACK0021'.
      CALL SCREEN '0002'.
    ENDCASE.

ENDMODULE.
