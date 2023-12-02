@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'BO Base View Urlaubsantrag'
define view entity zr_zgrph_vacrequest
  as select from zgrph_vacrequest
  association        to parent zr_zgrph_employee as _Employee      on $projection.RequestApplicant = _Employee.EmployeeId
  association [1..1] to zi_zgrph_ApproverText    as _ApproverText  on $projection.RequestApprover = _ApproverText.EmployeeId
  association [1..1] to zi_zgrph_ApplicantText   as _ApplicantText on $projection.RequestApplicant = _ApplicantText.EmployeeId
{
  key zgrph_vacrequest.request_id        as RequestId,
      @EndUserText: { label: 'Request Applicant', quickInfo: 'Request Applicant' }
      @ObjectModel.text.element: ['ApplicantName']
      zgrph_vacrequest.request_applicant as RequestApplicant,
      @EndUserText: { label: 'Request Approver', quickInfo: 'Request Approver' }
      @ObjectModel.text.element: ['ApproverName']
      zgrph_vacrequest.request_approver  as RequestApprover,
      zgrph_vacrequest.start_date        as StartDate,
      zgrph_vacrequest.end_date          as EndDate,
      zgrph_vacrequest.request_comment   as RequestComment,
      zgrph_vacrequest.request_status    as RequestStatus,
      @Semantics.user.createdBy: true
      zgrph_vacrequest.created_by        as CreatedBy,
      @Semantics.systemDateTime.createdAt: true
      zgrph_vacrequest.created_at        as CreatedAt,
      @Semantics.user.lastChangedBy: true
      zgrph_vacrequest.last_changed_by   as LastChangedBy,
      @Semantics.systemDateTime.lastChangedAt: true
      zgrph_vacrequest.last_changed_at   as LastChangedAt,

      _Employee,
      _ApproverText.Name                 as ApproverName,
      _ApplicantText.Name                as ApplicantName,

      case request_status when 'G' then 3
                          when 'B' then 0
                          when 'A' then 1
                          else 0
      end                                as StatusCriticality


}
