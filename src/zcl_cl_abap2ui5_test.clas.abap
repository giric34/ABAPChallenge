class ZCL_CL_ABAP2UI5_TEST definition
  public
  create public .

public section.
 INTERFACES z2ui5_if_app.
  DATA: name TYPE string,
        date TYPE sy-datum.


  interfaces IF_HTTP_SERVICE_EXTENSION .
protected section.
private section.
ENDCLASS.



CLASS ZCL_CL_ABAP2UI5_TEST IMPLEMENTATION.


  method IF_HTTP_SERVICE_EXTENSION~HANDLE_REQUEST.

   z2ui5_cl_http_handler=>client = VALUE #(
      t_header = request->get_header_fields( )
      t_param  = request->get_form_fields( )
      body     = request->get_text( ) ).

   DATA(lv_resp) = SWITCH #( request->get_method( )
      WHEN 'GET'  THEN z2ui5_cl_http_handler=>http_get( )
      WHEN 'POST' THEN z2ui5_cl_http_handler=>http_post( ) ).

   response->set_status( 200 )->set_text( lv_resp ).
  endmethod.

  METHOD z2ui5_if_app~main.

    "event handling
    CASE client->get( )-event.
      WHEN 'BUTTON_POST'.
        client->popup_message_toast( |{ name } { date } - sent to the server| ).
    ENDCASE.

    "view rendering
    client->set_next( VALUE #( xml_main = z2ui5_cl_xml_view=>factory(
        )->page( title = 'Open Source ABAP - Challenge 2'
            )->simple_form( title = 'Form Title' editable = abap_true
                )->content( 'form'
                    )->title( 'Input'
                    )->label( 'User'
                    )->input( client->_bind( name )
                    )->label( 'Date'
                    )->input( client->_bind( val = date )
                    )->button( text  = 'post' press = client->_event( 'BUTTON_POST' )
         )->get_root( )->xml_get( ) ) ).

  ENDMETHOD.
ENDCLASS.
