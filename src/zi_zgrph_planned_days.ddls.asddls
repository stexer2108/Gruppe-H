@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Wertehilfe geplante Tage'
define view entity zi_zgrph_planned_days
  as select from zgrph_vacrequest
{
  key request_applicant  as RequestApplicant,
      sum(vacation_days) as PlannedVacationDays
}

where
      request_status <> 'D'
  and end_date       >= $session.user_date
group by
  request_applicant;
