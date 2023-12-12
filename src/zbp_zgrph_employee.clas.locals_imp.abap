CLASS lhc_zr_zgrph_employee DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR zr_zgrph_employee RESULT result.

    METHODS validatedates FOR VALIDATE ON SAVE
      IMPORTING keys FOR zr_zgrph_vacrequest~ValidateDates.

    METHODS validateapprover FOR VALIDATE ON SAVE
      IMPORTING keys FOR zr_zgrph_vacrequest~ValidateApprover.

    METHODS get_instance_authorizations_1 FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR zr_zgrph_vacrequest RESULT result.

    METHODS ApproveRequest FOR MODIFY
      IMPORTING keys FOR ACTION zr_zgrph_vacrequest~ApproveRequest RESULT result.

    METHODS RejectRequest FOR MODIFY
      IMPORTING keys FOR ACTION zr_zgrph_vacrequest~RejectRequest RESULT result.

    METHODS determineStatus FOR DETERMINE ON MODIFY
      IMPORTING keys FOR zr_zgrph_vacrequest~determineStatus.

    METHODS detemineavailabledays FOR DETERMINE ON MODIFY
      IMPORTING keys FOR zr_zgrph_vacrequest~detemineavailabledays.

ENDCLASS.

CLASS lhc_zr_zgrph_employee IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD detemineAvailableDays.

  TRY.
    "DEFINE CALENDAR
    DATA(calendar) = cl_fhc_calendar_runtime=>create_factorycalendar_runtime( 'SAP_DE_BW' ).

    " Read Travels
    READ ENTITY IN LOCAL MODE zr_zgrph_vacrequest
         FIELDS ( VacationDays )
         WITH CORRESPONDING #( keys )
         RESULT DATA(requests).

    " Modify Travels
    MODIFY ENTITY IN LOCAL MODE zr_zgrph_vacrequest
           UPDATE FIELDS ( VacationDays )
           WITH VALUE #( FOR t IN requests
                         ( %tky   = t-%tky
                           VacationDays = calendar->calc_workingdays_between_dates( iv_start = t-StartDate  iv_end = t-EndDate ) ) ).
   CATCH cx_root INTO DATA(error).

  ENDTRY.
  ENDMETHOD.

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
        message = NEW zcm_zgrph_employee( textid = zcm_zgrph_employee=>approver_must_exist
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
        APPEND VALUE #( %tky = request->%tky %msg = message ) TO reported-zr_zgrph_vacrequest.
        APPEND VALUE #( %tky = request->%tky ) TO failed-zr_zgrph_vacrequest.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD get_instance_authorizations_1.
  ENDMETHOD.

  METHOD ApproveRequest.
    DATA message TYPE REF TO zcm_zgrph_employee.

    READ ENTITY IN LOCAL MODE zr_zgrph_vacrequest
    FIELDS ( RequestStatus RequestComment )
    WITH CORRESPONDING #( keys )
    RESULT DATA(vacreqs).

    LOOP AT vacreqs REFERENCE INTO DATA(vacreq).

      IF vacreq->RequestStatus = 'G'.
        message = NEW zcm_zgrph_employee( textid = zcm_zgrph_employee=>request_already_approved
                                          severity = if_abap_behv_message=>severity-error
                                          comment = vacreq->RequestComment
                                          ).
        APPEND VALUE #( %tky = vacreq->%tky %msg     = message ) TO reported-zr_zgrph_vacrequest.
        APPEND VALUE #( %tky = vacreq->%tky ) TO failed-zr_zgrph_vacrequest.
        DELETE vacreqs INDEX sy-tabix.
        CONTINUE.
      ENDIF.

      vacreq->RequestStatus = 'G'.
      message = NEW zcm_zgrph_employee( textid       = zcm_zgrph_employee=>request_approved_successfully
                                        severity     = if_abap_behv_message=>severity-success
                                        comment = vacreq->RequestComment
                                        ).

      APPEND VALUE #( %tky = vacreq->%tky %msg = message ) TO reported-zr_zgrph_vacrequest.
    ENDLOOP.

    MODIFY ENTITY IN LOCAL MODE zr_zgrph_vacrequest
           UPDATE FIELDS ( RequestStatus )
           WITH VALUE #( FOR t IN vacreqs ( %tky = t-%tky RequestStatus = t-RequestStatus ) ).

    result = VALUE #( FOR t IN vacreqs ( %tky = t-%tky %param = t ) ).
  ENDMETHOD.

  METHOD RejectRequest.
  DATA message TYPE REF TO zcm_zgrph_employee.

    READ ENTITY IN LOCAL MODE zr_zgrph_vacrequest
    FIELDS ( RequestStatus RequestComment )
    WITH CORRESPONDING #( keys )
    RESULT DATA(vacreqs).

    LOOP AT vacreqs REFERENCE INTO DATA(vacreq).

      IF vacreq->RequestStatus = 'A'.
        message = NEW zcm_zgrph_employee( textid = zcm_zgrph_employee=>request_already_rejected
                                          severity = if_abap_behv_message=>severity-error
                                          comment = vacreq->RequestComment
                                          ).
        APPEND VALUE #( %tky = vacreq->%tky %msg     = message ) TO reported-zr_zgrph_vacrequest.
        APPEND VALUE #( %tky = vacreq->%tky ) TO failed-zr_zgrph_vacrequest.
        DELETE vacreqs INDEX sy-tabix.
        CONTINUE.
      ENDIF.

      vacreq->RequestStatus = 'A'.
      message = NEW zcm_zgrph_employee( severity     = if_abap_behv_message=>severity-success
                                        textid       = zcm_zgrph_employee=>request_rejected
                                        comment = vacreq->RequestComment
                                        ).

      APPEND VALUE #( %tky = vacreq->%tky
                      %element = VALUE #( RequestStatus = if_abap_behv=>mk-on )
                      %msg = message ) TO reported-zr_zgrph_vacrequest.
    ENDLOOP.

    MODIFY ENTITY IN LOCAL MODE zr_zgrph_vacrequest
           UPDATE FIELDS ( RequestStatus )
           WITH VALUE #( FOR t IN vacreqs ( %tky = t-%tky RequestStatus = t-RequestStatus ) ).

    result = VALUE #( FOR t IN vacreqs ( %tky = t-%tky ) ).
  ENDMETHOD.

  METHOD determineStatus.
    READ ENTITY IN LOCAL MODE zr_zgrph_vacrequest
    FIELDS ( RequestStatus )
    WITH CORRESPONDING #( keys )
    RESULT DATA(vacreqs).

    MODIFY ENTITY IN LOCAL MODE zr_zgrph_vacrequest
    UPDATE FIELDS ( RequestStatus )
    WITH VALUE #( FOR t IN vacreqs ( %tky = t-%tky RequestStatus  = 'B' ) ).
  ENDMETHOD.

ENDCLASS.
