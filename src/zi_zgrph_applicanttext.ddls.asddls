@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface View Approver'
define root view entity zi_zgrph_ApplicantText
as select from zgrph_employee
{
    key employee_id as EmployeeId,
    forename as Forename,
    surename as Surename,
    
    concat_with_space(forename, surename, 1) as Name
}
