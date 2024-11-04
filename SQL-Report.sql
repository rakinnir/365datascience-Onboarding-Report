-- Total Members
SELECT
    COUNT(user_id) AS [Total Members]
FROM data_survey;

-- Total Paid Members and Percentage of Paid Members
SELECT
    COUNT(user_paid) AS [Total Paid Members],
    CAST(COUNT(user_paid) * 100.0 / (SELECT COUNT(user_id) FROM data_survey) AS DECIMAL(4, 0)) AS [Paid Member Percentage]
FROM data_survey
WHERE user_paid = 'Paid';

-- Total Survey Completions and Survey Completion Percentage
SELECT
    COUNT(CASE WHEN onboarded = 'Onboarded' THEN 'Surveyed' END) AS [Total Surveys Completed],
    CAST(COUNT(CASE WHEN onboarded = 'Onboarded' THEN 'Surveyed' END) * 100.0 / COUNT(user_id) AS DECIMAL(10, 0)) AS [Survey Completion Percentage]
FROM data_survey;

-- Monthly Registration Trend
SELECT
    DATENAME(MONTH, user_registered) AS [Month],
    COUNT(user_registered) AS [Total Registrations]
FROM data_survey
GROUP BY DATENAME(MONTH, user_registered), MONTH(user_registered)
ORDER BY MONTH(user_registered);

-- Monthly Survey Completion Trend
SELECT
    DATENAME(MONTH, completed_date) AS [Month],
    COUNT(completed_date) AS [Total Surveys Completed]
FROM data_survey
WHERE completed_date IS NOT NULL
GROUP BY DATENAME(MONTH, completed_date), MONTH(completed_date)
ORDER BY MONTH(completed_date);

-- Top 5 Countries by Member Count
SELECT TOP 5
    onboarding_country AS [Country],
    COUNT(onboarding_country) AS [Total Members]
FROM data_survey
GROUP BY onboarding_country
ORDER BY [Total Members] DESC;

-- Distribution of Subscription Types
SELECT
    subscription_type AS [Subscription Type],
    COUNT(subscription_type) AS [Total],
    CAST(COUNT(subscription_type) * 100.0 / (SELECT COUNT(subscription_type) FROM data_survey) AS DECIMAL(4, 0)) AS [Percentage]
FROM data_survey
WHERE subscription_type IS NOT NULL
GROUP BY subscription_type
ORDER BY Total DESC;

-- Top 5 Sources Members Heard About the Platform From
SELECT TOP 5
    onboarding_heard_from_label AS [Source],
    COUNT(onboarding_heard_from_label) AS [Total]
FROM data_survey
GROUP BY onboarding_heard_from_label
ORDER BY Total DESC;

-- Members by Primary Interest Topics
SELECT 
    onboarding_learn_label AS [Primary Interest Topic],
    COUNT(onboarding_learn_label) AS [Total]
FROM data_survey
WHERE onboarding_learn_label IS NOT NULL
GROUP BY onboarding_learn_label
ORDER BY Total DESC;

-- Members by Learning Goal
SELECT 
    onboarding_goals_label AS [Learning Goal],
    COUNT(onboarding_goals_label) AS [Total]
FROM data_survey
WHERE onboarding_goals_label IS NOT NULL
GROUP BY onboarding_goals_label
ORDER BY Total DESC;
