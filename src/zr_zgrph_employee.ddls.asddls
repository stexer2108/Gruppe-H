@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'BO Base View Mitarbeiter'
/*+[hideWarning] { "IDS" : [ "CARDINALITY_CHECK" ]  } */
define root view entity zr_zgrph_employee
  as select from zgrph_employee
  composition [0..*] of zr_zgrph_vacent         as _Vacent
  composition [0..*] of zr_zgrph_vacrequest     as _Vacrequest
  association [1..1] to zi_zgrph_available_days as _AvailableDays on $projection.EmployeeId = _AvailableDays.EmployeeId
  association [1..1] to zi_zgrph_planned_days   as _PlannedDays   on $projection.EmployeeId = _PlannedDays.RequestId
  association [1..1] to zi_zgrph_consumed_days  as _ConsumedDays  on $projection.EmployeeId = _ConsumedDays.RequestId

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
      _Vacrequest,
      
      _AvailableDays.AvailableDays as AvailableVacationDays,
      _ConsumedDays.ConsumedVacationDays as ConsumedVacationDays,
      _PlannedDays.PlannedVacationDays as PlannedVacationDays,
      
      '3' as AvailableDaysCriticality,
      '2' as PlannedDaysCriticality,
      '1' as ConsumedDaysCriticality
}
