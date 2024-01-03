type timeZoneObject = {timeZone: string}
@send external toLocaleString: (Js.Date.t, string, timeZoneObject) => string = "toLocaleString"

type dateTime = {
  year: float,
  month: float,
  date: float,
  hour: float,
  minute: float,
  second: float,
}

let timezoneOffset = Js.Dict.fromList(list{("IST", "+05:30"), ("GMT", "+00:00")})
let timezoneLocation = Js.Dict.fromList(list{("IST", "Asia/Kolkata"), ("GMT", "UTC")})

let formatter = str => {
  Js.String.length(str) == 0 ? "00" : Js.String.length(str) == 1 ? `0${str}` : str
}

let convertTimeZone = (date, timezoneString) => {
  let localTimeString = Js.Date.fromString(date)
  toLocaleString(localTimeString, "en-US", {timeZone: timezoneString})
}

let isoStringToCustomTimezone = isoString => {
  let timezone = "IST"

  let timezoneString = switch Dict.get(timezoneLocation, timezone) {
  | Some(d) => d
  | None => "Asia/Kolkata"
  }

  let timezoneConvertedString = convertTimeZone(isoString, timezoneString)
  let timezoneConverted = Js.Date.fromString(timezoneConvertedString)
  let timeZoneYear = Js.Date.getFullYear(timezoneConverted)
  let timeZoneMonth = Js.Date.getMonth(timezoneConverted)
  let timeZoneDate = Js.Date.getDate(timezoneConverted)
  let timeZoneHour = Js.Date.getHours(timezoneConverted)
  let timeZoneMinute = Js.Date.getMinutes(timezoneConverted)
  let timeZoneSecond = Js.Date.getSeconds(timezoneConverted)
  let customDateTime: dateTime = {
    year: timeZoneYear,
    month: timeZoneMonth,
    date: timeZoneDate,
    hour: timeZoneHour,
    minute: timeZoneMinute,
    second: timeZoneSecond,
  }
  customDateTime
}

let customTimezoneToISOString = (year, month, day, hours, minutes, seconds, _timezone) => {
  let timezone = "IST"

  let timezoneString = switch Dict.get(timezoneOffset, timezone) {
  | Some(d) => d
  | None => "+05:30"
  }

  let monthString = Js.String.length(month) == 1 ? `0${month}` : month
  let dayString = Js.String.length(day) == 1 ? `0${day}` : day
  let hoursString = formatter(hours)
  let minutesString = formatter(minutes)
  let secondsString = formatter(seconds)

  let fullTimeManagedString =
    year ++
    "-" ++
    monthString ++
    "-" ++
    dayString ++
    "T" ++
    hoursString ++
    ":" ++
    minutesString ++
    ":" ++
    secondsString ++
    timezoneString
  let newFormedDate = Js.Date.fromString(fullTimeManagedString)
  let isoFormattedDate = Js.Date.toISOString(newFormedDate)

  isoStringToCustomTimezone(isoFormattedDate)->ignore
  isoFormattedDate
}
// return new Date((typeof date === "string" ? new Date(date) : date).toLocaleString("en-US", {timeZone: timezoneString})); 
