@EndUserText.label: 'BO Projection View Urlaubsanspruch'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
define view entity zc_zgrph_vacent
  as projection on zr_zgrph_vacent
{
  key EntitlementId,
      EmployeeId,
      EntitlementYear,
      Vacationdays,
      CreatedBy,
      CreatedAt,
      LastChangedBy,
      LastChangedAt,

      /* Associations */
      _Employee : redirected to parent zc_zgrph_employee
}
