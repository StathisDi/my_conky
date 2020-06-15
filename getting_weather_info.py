import requests
import xmltodict
import re



def get_info_of_future_period(period_now, dist_of_future_period_to_current_days_period0):
    #same reasoning as get_next_day
    #but now, the period needed is 10 periods away, instead of 6

    period_now = int(period_now)

    # period in this api is the day segment: 00-06, 06-12, 12-18, 18-24
    # the next day's period 2 (12.00-18.00) is 6 periods after the period 0 (00.00-06.00) in the current day
    #so dist_of_period_wanted_to_current_days_period0 = 6, if we want to get next day's period 2
    # as the period in the current day increases, the next day at 12 gets closer, that is why we subtract
    period_wanted_idx = dist_of_future_period_to_current_days_period0 - period_now

    period_wanted = ((((weatherdict['weatherdata'])['forecast'])['tabular'])['time'])[period_wanted_idx]
    return period_wanted


def get_useful_info(day):
    temperature = int((now['temperature'])['@value'])
    precipitation = int((now['precipitation'])['@value'])
    symbol = (now['symbol'])['@var']

    return temperature, precipitation, symbol


if __name__ == "__main__":
    r = requests.get('https://www.yr.no/place/Sweden/Stockholm/Solna/forecast.xml')
    weatherdict = xmltodict.parse(r.text)

    now = ((((weatherdict['weatherdata'])['forecast'])['tabular'])['time'])[0]
    temperature_now, precipitation_now, symbol_now = get_useful_info(now)

    next_day =  get_info_of_future_period(now['@period'],6)
    temperature_next_day, precipitation_next_day, symbol_next_day = get_useful_info(next_day)

    two_days_later = get_info_of_future_period(now['@period'], 10)
    temperature_two_days_later, precipitation_two_days_later, symbol_two_days_later = get_useful_info(next_day)

    a = 1