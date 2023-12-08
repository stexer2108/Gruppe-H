@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Wertehilfe verbrauchte Tage'
define view entity zi_zgrph_consumed_days
  as select from zgrph_vacrequest
{
  key request_applicant  as RequestApplicant,
      sum(vacation_days) as ConsumedVacationDays
}

where
      request_status = 'G'
  and end_date       < $session.user_date
group by
  request_applicant;
