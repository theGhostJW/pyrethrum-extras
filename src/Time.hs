module Time (
  utcToOffsetDateTime,
  offsetDateTimeToUtc
) where

import Chronos
import Data.Time ( UTCTime (..))
import BasePrelude

-- TODO :: UnTested Test
utcToOffsetDateTime :: UTCTime -> OffsetDatetime
utcToOffsetDateTime UTCTime{utctDay, utctDayTime} =
  OffsetDatetime
    { offsetDatetimeDatetime =
        Datetime
          { datetimeDate = toEnum $ fromEnum utctDay
          , datetimeTime =
              TimeOfDay
                { timeOfDayHour = mins `div` 60
                , timeOfDayMinute = mins `mod` 60
                , timeOfDayNanoseconds = fromIntegral $ round $ (secs - fromIntegral iSecs) * 1000000000
                }
          }
    , offsetDatetimeOffset = Offset 0
    }
 where
  secs = realToFrac utctDayTime
  iSecs = floor secs
  mins = iSecs `div` 60

-- TODO :: UnTested Test
offsetDateTimeToUtc :: OffsetDatetime -> UTCTime
offsetDateTimeToUtc OffsetDatetime{offsetDatetimeDatetime = Datetime{datetimeDate, datetimeTime}} =
  UTCTime
    { utctDay = toEnum $ fromEnum datetimeDate
    , utctDayTime =
        fromIntegral (timeOfDayHour datetimeTime * 60 * 60)
          + fromIntegral (timeOfDayMinute datetimeTime * 60)
          + fromIntegral (timeOfDayNanoseconds datetimeTime)
          + 0
    }
