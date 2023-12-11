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
      @Consumption.valueHelpDefinition: [{ entity: { name: 'zi_zgrph_ApproverVH', element: 'EmployeeId'} }]
      RequestApprover,
      StartDate,
      EndDate,
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.7
      RequestComment,
      RequestStatus,
      VacationDays,
      CreatedBy,
      CreatedAt,
      LastChangedBy,
      LastChangedAt,


      /* Associations */
      _Employee : redirected to parent zc_zgrph_employee,
      _Approver : redirected to zc_zgrph_employee,

      ApproverName,
      ApplicantName,
      
      StatusCriticality
}
