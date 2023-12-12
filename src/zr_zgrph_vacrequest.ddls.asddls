@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'BO Base View Urlaubsantrag'
define view entity zr_zgrph_vacrequest
  as select from zgrph_vacrequest
  association        to parent zr_zgrph_employee as _Employee      on $projection.RequestApplicant = _Employee.EmployeeId
  association        to zr_zgrph_employee        as _Approver      on $projection.RequestApprover = _Approver.EmployeeId
  association [1..1] to zi_zgrph_ApproverText    as _ApproverText  on $projection.RequestApprover = _ApproverText.EmployeeId
  association [1..1] to zi_zgrph_ApplicantText   as _ApplicantText on $projection.RequestApplicant = _ApplicantText.EmployeeId
{
  key request_id        as RequestId,
      @EndUserText: { label: 'RequestApplicant', quickInfo: 'Request Applicant' }
      @ObjectModel.text.element: ['ApplicantName']
      request_applicant as RequestApplicant,
      @EndUserText: { label: 'RequestApprover', quickInfo: 'Request Approver' }
      @ObjectModel.text.element: ['ApproverName']
      request_approver  as RequestApprover,
      start_date        as StartDate,
      end_date          as EndDate,
      request_comment   as RequestComment,
      request_status    as RequestStatus,
      vacation_days     as VacationDays,
      created_by        as CreatedBy,
      created_at        as CreatedAt,
      last_changed_by   as LastChangedBy,
      last_changed_at   as LastChangedAt,

      _Employee,
      _Approver,
      _ApproverText.Name                 as ApproverName,
      _ApplicantText.Name                as ApplicantName,

      case request_status when 'G' then 3
                          when 'B' then 2
                          when 'A' then 1
                          else 0
      end                                as StatusCriticality


}
