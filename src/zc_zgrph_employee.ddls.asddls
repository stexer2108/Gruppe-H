@EndUserText.label: 'BO Projection View Mitarbeiter'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Search.searchable: true
@Metadata.allowExtensions: true
define root view entity zc_zgrph_employee
  provider contract transactional_query
  as projection on zr_zgrph_employee
{
      @Consumption.valueHelpDefinition: [{ entity: { name: 'zi_zgrph_ApproverVH', element: 'EmployeeId'} }]
  key EmployeeId,
      EmployeeNumber,
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.7
      Forename,
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.7
      Surename,
      EntryDate,
      CreatedBy,
      CreatedAt,
      LastChangedBy,
      LastChangedAt,

      ApproverName,

      /* Associations */
      _Vacent     : redirected to composition child zc_zgrph_vacent,
      _Vacrequest : redirected to composition child zc_zgrph_vacrequest

}
