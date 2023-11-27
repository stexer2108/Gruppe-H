@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'BO Base View Urlaubsanspruch'
define view entity zr_zgrph_vacent
  as select from zgrph_vacent
  association to parent zr_zgrph_employee as _Employee on $projection.EmployeeId = _Employee.EmployeeId
{
  key entitlement_id   as EntitlementId,
      employee_id      as EmployeeId,
      entitlement_year as EntitlementYear,
      vacationdays     as Vacationdays,
      created_by       as CreatedBy,
      created_at       as CreatedAt,
      last_changed_by  as LastChangedBy,
      last_changed_at  as LastChangedAt,

      _Employee

}
