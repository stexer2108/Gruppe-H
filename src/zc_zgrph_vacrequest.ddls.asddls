@EndUserText.label: 'BO Projection View Urlaubsantrag'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Search.searchable: true
@Metadata.allowExtensions: true
define view entity zc_zgrph_vacrequest
  as projection on zr_zgrph_vacrequest
{
  key RequestId,
      @Consumption.valueHelpDefinition: [{ entity: { name: 'zi_zgrph_ApplicantVH', element: 'RequestApplicant'} }]
      RequestApplicant,
      @Consumption.valueHelpDefinition: [{ entity: { name: 'zi_zgrph_ApproverVH', element: 'RequestApprover'} }]
      RequestApprover,
      StartDate,
      EndDate,
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.7
      RequestComment,
      @Consumption.valueHelpDefinition: [{ entity: { name: 'ZI_ZGRPH_StatusVH', element: 'RequestStatus' } }]
      RequestStatus,
      CreatedBy,
      CreatedAt,
      LastChangedBy,
      LastChangedAt,


      /* Associations */
      _Employee : redirected to parent zc_zgrph_employee,

      ApproverName,
      ApplicantName,
      
      StatusCriticality
}
