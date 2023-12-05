CLASS lhc_zr_zgrph_employee DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR zr_zgrph_employee RESULT result.

    METHODS validatedates FOR VALIDATE ON SAVE
      IMPORTING keys FOR zr_zgrph_vacrequest~ValidateDates.

    METHODS validateapprover FOR VALIDATE ON SAVE
      IMPORTING keys FOR zr_zgrph_vacrequest~ValidateApprover.

*    METHODS detemineavailabledays FOR DETERMINE ON MODIFY
*      IMPORTING keys FOR zr_zgrph_employee~detemineavailabledays.

ENDCLASS.

CLASS lhc_zr_zgrph_employee IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

*  METHOD showTestMessage.
*    DATA message TYPE REF TO zcm_zgrph_employee.
*
*    message = NEW zcm_zgrph_employee( severity = if_abap_behv_message=>severity-success
*                                      textid = zcm_zgrph_employee=>test_message
*                                      surename = sy-repid ).
*
*    APPEND message TO reported-%other.
*  ENDMETHOD.

*  METHOD detemineAvailableDays.
*    " Read Employee
*    READ ENTITY IN LOCAL MODE zr_zgrph_vacrequest
*         FIELDS ( startDate endDate )
*         WITH CORRESPONDING #( keys )
*         RESULT DATA(availableDays).
*
*    LOOP AT availableDays REFERENCE INTO DATA(availableday).
*
*    DATA(calendar) = cl_fhc_calendar_runtime=>create_factorycalendar_runtime( 'SAP_DE_BW' ).
*    DATA(working_days) = calendar->calc_workingdays_between_dates( iv_start = availableDays=>startDate iv_end = '20240107' ).
*
*    ENDLOOP.
*
*
*
*    " Modify Travels
*    MODIFY ENTITY IN LOCAL MODE zr_zgrph_employee
*           UPDATE FIELDS ( AvailableDays )
*           WITH VALUE #( FOR i IN availableDays
*                         ( %tky     = i-%tky
*                           AvailableDays = i-AvailableDays ) ).
*
*  ENDMETHOD.

  METHOD validateapprover.
    DATA message TYPE REF TO zcm_zgrph_employee.

    READ ENTITY IN LOCAL MODE zr_zgrph_vacrequest
         FIELDS ( RequestApprover )
         WITH CORRESPONDING #( keys )
         RESULT DATA(employees).

    LOOP AT employees INTO DATA(employee).

      SELECT SINGLE FROM zgrph_employee FIELDS @abap_true
            WHERE employee_id = @employee-RequestApprover INTO @DATA(exists).

      IF exists = abap_false.
        message = NEW zcm_zgrph_employee( textid      = zcm_zgrph_employee=>approver_must_exist
                                          severity = if_abap_behv_message=>severity-error ).
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD validatedates.
    DATA message TYPE REF TO zcm_zgrph_employee.

    READ ENTITY IN LOCAL MODE zr_zgrph_vacrequest
         FIELDS ( StartDate EndDate )
         WITH CORRESPONDING #( keys )
         RESULT DATA(requests).

    LOOP AT requests REFERENCE INTO DATA(request).

      IF request->EndDate < request->StartDate.
        message = NEW zcm_zgrph_employee( textid = zcm_zgrph_employee=>endDate_after_startDate
                                          severity = if_abap_behv_message=>severity-error ).

*        APPEND VALUE #( %tky = request->%tky
*                        %msg = message ) TO reported-request.
*        APPEND VALUE #( %tky = request-%tky ) TO failed-request.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

ENDCLASS.
