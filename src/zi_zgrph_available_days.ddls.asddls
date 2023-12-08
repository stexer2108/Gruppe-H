@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Wertehilfe verfügbare Tage'
define root view entity zi_zgrph_available_days
  as select from zgrph_vacent
  association [1..1] to zi_zgrph_consumed_days as _ConsumedDays on $projection.EmployeeId = _ConsumedDays.RequestApplicant
  association [1..1] to zi_zgrph_planned_days  as _PlannedDays  on $projection.EmployeeId = _PlannedDays.RequestApplicant

{
  key zgrph_vacent.employee_id                          as EmployeeId,

      sum(vacationdays) - coalesce(_ConsumedDays.ConsumedVacationDays, 0)
        - coalesce(_PlannedDays.PlannedVacationDays, 0) as AvailableDays
}
group by
  zgrph_vacent.employee_id,
  _ConsumedDays.ConsumedVacationDays,
  _PlannedDays.PlannedVacationDays;
