@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Wertehilfe Approver'
define view entity zi_zgrph_ApproverVH
  as select from zgrph_employee
{
      @UI.hidden: true
  key employee_id as EmployeeId,
      forename    as Forename,
      surename    as Surename
}
