CLASS zcl_zgrph_employee_generator DEFINITION PUBLIC FINAL CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
ENDCLASS.

CLASS zcl_zgrph_employee_generator IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.

    DATA employees TYPE TABLE OF zgrph_employee.
    DATA employee TYPE zgrph_employee.

    DATA vacents TYPE TABLE OF zgrph_vacent.
    DATA vacent TYPE zgrph_vacent.

    DATA vacrequests TYPE TABLE OF zgrph_vacrequest.
    DATA vacrequest TYPE zgrph_vacrequest.

    DATA: Hans_UUID TYPE sysuuid_x16.
    DATA: Lisa_UUID TYPE sysuuid_x16.
    DATA: Petra_UUID TYPE sysuuid_x16.

    out->write( sy-dbcnt ).


    " Einträge löschen
    DELETE FROM zgrph_employee.
    DELETE FROM zgrph_vacent.
    DELETE FROM zgrph_vacrequest.


    " Mitarbeiter erstellen
    Hans_UUID = cl_system_uuid=>create_uuid_x16_static( ).
    employee-employee_id = Hans_UUID.
    employee-employee_number = '000001'.
    employee-forename = 'Hans'.
    employee-surename = 'Maier'.
    employee-entry_date = '20000501'.
    employee-created_by = 'GENERATOR'.
    GET TIME STAMP FIELD employee-created_at.
    employee-last_changed_by = 'GENERATOR'.
    GET TIME STAMP FIELD employee-last_changed_at.
    APPEND employee TO employees.

    " Urlaubsanspruch erstellen
    vacent-entitlement_id = cl_system_uuid=>create_uuid_x16_static( ).
    vacent-employee_id = Hans_UUID.
    vacent-entitlement_year = '2022'.
    vacent-vacationdays = '30'.
    APPEND vacent TO vacents.

    " Urlaubsanspruch erstellen
    vacent-entitlement_id = cl_system_uuid=>create_uuid_x16_static( ).
    vacent-employee_id = Hans_UUID.
    vacent-entitlement_year = '2023'.
    vacent-vacationdays = '30'.
    APPEND vacent TO vacents.


    " Mitarbeiter erstellen
    Lisa_UUID = cl_system_uuid=>create_uuid_x16_static( ).
    employee-employee_id = Lisa_UUID.
    employee-employee_number = '000002'.
    employee-forename = 'Lisa'.
    employee-surename = 'Müller'.
    employee-entry_date = '20100701'.
    employee-created_by = 'GENERATOR'.
    GET TIME STAMP FIELD employee-created_at.
    employee-last_changed_by = 'GENERATOR'.
    GET TIME STAMP FIELD employee-last_changed_at.
    APPEND employee TO employees.

    " Urlaubsanspruch erstellen
    vacent-entitlement_id = cl_system_uuid=>create_uuid_x16_static( ).
    vacent-employee_id = Lisa_UUID.
    vacent-entitlement_year = '2023'.
    vacent-vacationdays = '30'.
    APPEND vacent TO vacents.


    " Mitarbeiter erstellen
    Petra_UUID = cl_system_uuid=>create_uuid_x16_static( ).
    employee-employee_id = Petra_UUID.
    employee-employee_number = '000003'.
    employee-forename = 'Petra'.
    employee-surename = 'Schmid'.
    employee-entry_date = '20231001'.
    employee-created_by = 'GENERATOR'.
    GET TIME STAMP FIELD employee-created_at.
    employee-last_changed_by = 'GENERATOR'.
    GET TIME STAMP FIELD employee-last_changed_at.
    APPEND employee TO employees.

    " Urlaubsanspruch erstellen
    vacent-entitlement_id = cl_system_uuid=>create_uuid_x16_static( ).
    vacent-employee_id = Petra_UUID.
    vacent-entitlement_year = '2023'.
    vacent-vacationdays = '7'.
    APPEND vacent TO vacents.



    " Urlaubsantrag erstellen
    vacrequest-request_id = cl_system_uuid=>create_uuid_x16_static( ).
    vacrequest-request_applicant = Hans_UUID.
    vacrequest-request_approver = Lisa_UUID.
    vacrequest-start_date = '20220701'.
    vacrequest-end_date = '20220710'.
    vacrequest-request_comment = 'Sommerurlaub'.
    vacrequest-request_status = 'G'.
    APPEND vacrequest TO vacrequests.

    " Urlaubsantrag erstellen
    vacrequest-request_id = cl_system_uuid=>create_uuid_x16_static( ).
    vacrequest-request_applicant = Hans_UUID.
    vacrequest-request_approver = Lisa_UUID.
    vacrequest-start_date = '20221227'.
    vacrequest-end_date = '20221230'.
    vacrequest-request_comment = 'Weihnachtsurlaub'.
    vacrequest-request_status = 'A'.
    APPEND vacrequest TO vacrequests.

    " Urlaubsantrag erstellen
    vacrequest-request_id = cl_system_uuid=>create_uuid_x16_static( ).
    vacrequest-request_applicant = Hans_UUID.
    vacrequest-request_approver = Lisa_UUID.
    vacrequest-start_date = '20221228'.
    vacrequest-end_date = '20221230'.
    vacrequest-request_comment = 'Weihnachtsurlaub (2. Versuch)'.
    vacrequest-request_status = 'G'.
    APPEND vacrequest TO vacrequests.

    " Urlaubsantrag erstellen
    vacrequest-request_id = cl_system_uuid=>create_uuid_x16_static( ).
    vacrequest-request_applicant = Hans_UUID.
    vacrequest-request_approver = Lisa_UUID.
    vacrequest-start_date = '20230527'.
    vacrequest-end_date = '20230614'.
    vacrequest-request_comment = ' '.
    vacrequest-request_status = 'G'.
    APPEND vacrequest TO vacrequests.

    " Urlaubsantrag erstellen
    vacrequest-request_id = cl_system_uuid=>create_uuid_x16_static( ).
    vacrequest-request_applicant = Hans_UUID.
    vacrequest-request_approver = Lisa_UUID.
    vacrequest-start_date = '20231220'.
    vacrequest-end_date = '20231231'.
    vacrequest-request_comment = 'Winterurlaub'.
    vacrequest-request_status = 'B'.
    APPEND vacrequest TO vacrequests.

    " Urlaubsantrag erstellen
    vacrequest-request_id = cl_system_uuid=>create_uuid_x16_static( ).
    vacrequest-request_applicant = Petra_UUID.
    vacrequest-request_approver = Hans_UUID.
    vacrequest-start_date = '20231227'.
    vacrequest-end_date = '20231231'.
    vacrequest-request_comment = 'Weihnachtsurlaub'.
    vacrequest-request_status = 'B'.
    APPEND vacrequest TO vacrequests.


    " Einträge hinzufügen
    INSERT zgrph_employee FROM TABLE @employees.
    INSERT zgrph_vacent FROM TABLE @vacents.
    INSERT zgrph_vacrequest FROM TABLE @vacrequests.

    out->write( sy-dbcnt ).


  ENDMETHOD.
ENDCLASS.
