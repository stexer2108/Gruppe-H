@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Wertehilfe verbrauchte Tage'
define view entity zi_zgrph_consumed_days 
as select from zgrph_vacrequest
{
    key request_id as RequestId,
    sum(vacation_days) as ConsumedVacationDays
}

where 
        request_status = 'A'
    and end_date < $session.user_date
group by request_id;
