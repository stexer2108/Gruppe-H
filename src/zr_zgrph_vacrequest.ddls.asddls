@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'BO Base View Urlaubsantrag'
define view entity zr_zgrph_vacrequest
  as select from zgrph_vacrequest
  association        to parent zr_zgrph_employee as _Employee     on $projection.RequestApplicant = _Employee.EmployeeId
  association [1..1] to zi_zgrph_ApproverText    as _ApproverText on $projection.RequestApprover = _ApproverText.EmployeeId

{
  key zgrph_vacrequest.request_id        as RequestId,
      zgrph_vacrequest.request_applicant as RequestApplicant,
      @ObjectModel.text.element: ['ApproverName']
      zgrph_vacrequest.request_approver  as RequestApprover,
      zgrph_vacrequest.start_date        as StartDate,
      zgrph_vacrequest.end_date          as EndDate,
      zgrph_vacrequest.request_comment   as RequestComment,
      zgrph_vacrequest.request_status    as RequestStatus,
      zgrph_vacrequest.created_by        as CreatedBy,
      zgrph_vacrequest.created_at        as CreatedAt,
      zgrph_vacrequest.last_changed_by   as LastChangedBy,
      zgrph_vacrequest.last_changed_at   as LastChangedAt,

      _Employee,
      _ApproverText.Name                 as ApproverName


}
