@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'BO Base View Mitarbeiter'
define root view entity zr_zgrph_employee
  as select from zgrph_employee
  composition [0..*] of zr_zgrph_vacent     as _Vacent
  composition [0..*] of zr_zgrph_vacrequest as _Vacrequest
{
  key employee_id     as EmployeeId,
      employee_number as EmployeeNumber,
      forename        as Forename,
      surename        as Surename,
      available_days  as AvailableDays,
      entry_date      as EntryDate,
      created_by      as CreatedBy,
      created_at      as CreatedAt,
      last_changed_by as LastChangedBy,
      last_changed_at as LastChangedAt,

      _Vacent,
      _Vacrequest

}
