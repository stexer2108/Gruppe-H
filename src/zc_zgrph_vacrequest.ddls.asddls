@EndUserText.label: 'BO Projection View Urlaubsantrag'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
define view entity zc_zgrph_vacrequest
  as projection on zr_zgrph_vacrequest
{
  key RequestId,
      RequestApplicant,
      RequestApprover,
      StartDate,
      EndDate,
      RequestComment,
      RequestStatus,
      CreatedBy,
      CreatedAt,
      LastChangedBy,
      LastChangedAt,


      /* Associations */
      _Employee : redirected to parent zc_zgrph_employee
}
