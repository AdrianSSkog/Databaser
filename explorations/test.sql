SELECT * FROM GameOfThrones

SELECT 
    Title,
    Season,
    EpisodeInSeason,
    'S' + FORMAT(Season, '00') +
    'E' + FORMAT(EpisodeInSeason, '00') AS Episodes

FROM GameOfThrones