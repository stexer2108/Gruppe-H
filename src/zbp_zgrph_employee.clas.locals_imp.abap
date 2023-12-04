CLASS lhc_zr_zgrph_employee DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR zr_zgrph_employee RESULT result.


    METHODS showtestmessage FOR MODIFY
      IMPORTING keys FOR ACTION zr_zgrph_employee~showtestmessage.

ENDCLASS.

CLASS lhc_zr_zgrph_employee IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD showTestMessage.
    DATA message TYPE REF TO zcm_zgrph_employee.

    message = NEW zcm_zgrph_employee( severity = if_abap_behv_message=>severity-success
                                      textid = zcm_zgrph_employee=>test_message
                                      surename = sy-repid ).

    APPEND message TO reported-%other.
  ENDMETHOD.

ENDCLASS.
