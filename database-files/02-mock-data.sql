
INSERT INTO permission (permission_id, action_type, resource) VALUES
(1,  'READ',   'reports'),
(2,  'WRITE',  'reports'),
(3,  'DELETE', 'reports'),
(4,  'READ',   'tickets'),
(5,  'WRITE',  'tickets'),
(6,  'DELETE', 'tickets'),
(7,  'READ',   'users'),
(8,  'WRITE',  'users'),
(9,  'DELETE', 'users'),
(10, 'READ',   'analytics'),
(11, 'EXPORT', 'analytics'),
(12, 'READ',   'system_logs');
 
INSERT INTO role (role_id, role_name, role_description) VALUES
(1, 'Admin',     'Full system access including user management and data export'),
(2, 'Analyst',   'Read-only access to reports and analytics dashboards'),
(3, 'Resident',  'Can submit and manage their own reports'),
(4, 'Moderator', 'Can review, edit, and flag community reports');
 
INSERT INTO role_permission (role_id, permission_id) VALUES
(1,1),(1,2),(1,3),(1,4),(1,5),(1,6),(1,7),(1,8),(1,9),(1,10),(1,11),(1,12),
(2,1),(2,4),(2,10),(2,11),
(3,1),(3,2),(3,4),
(4,1),(4,2),(4,3),(4,4),(4,5),(4,6);
 
INSERT INTO disability (disability_id, disability_name) VALUES
(1, 'Wheelchair'),
(2, 'Visual Impairment'),
(3, 'Hearing Impairment'),
(4, 'Cognitive Disability'),
(5, 'Walking Stick / Cane'),
(6, 'Prosthetic Limb');
 
INSERT INTO issue_type (issue_type_id, issue_type_name, issue_category) VALUES
(1,  'Pothole',                  'Road Hazard'),
(2,  'Missing Curb Cut',         'Sidewalk'),
(3,  'Broken Sidewalk',          'Sidewalk'),
(4,  'No Sidewalk',              'Sidewalk'),
(5,  'Steep Incline',            'Road Hazard'),
(6,  'Blocked Ramp',             'Ramp / Elevator'),
(7,  'Elevator Out of Service',  'Ramp / Elevator'),
(8,  'Snow / Ice Not Cleared',   'Winter Maintenance'),
(9,  'Unplowed Bike Lane',       'Winter Maintenance'),
(10, 'Bike Theft Location',      'Safety'),
(11, 'Poor Sidewalk Surface',    'Sidewalk'),
(12, 'Narrow Pathway',           'Accessibility Barrier');
 
INSERT INTO location (location_id, street_name, neighborhood_name, zip_code) VALUES
(1,  'Tremont Street',      'South End',     '02118'),
(2,  'Boylston Street',     'Back Bay',      '02116'),
(3,  'Commonwealth Avenue', 'Fenway',        '02215'),
(4,  'Blue Hill Avenue',    'Roxbury',       '02119'),
(5,  'Centre Street',       'Jamaica Plain', '02130'),
(6,  'Dorchester Avenue',   'Dorchester',    '02122'),
(7,  'Washington Street',   'South End',     '02118'),
(8,  'Cambridge Street',    'Allston',       '02134'),
(9,  'Meridian Street',     'East Boston',   '02128'),
(10, 'Warren Street',       'Roxbury',       '02119'),
(11, 'Huntington Avenue',   'Fenway',        '02115'),
(12, 'Hyde Park Avenue',    'Hyde Park',     '02136');
 
INSERT INTO obstructions (obstruction_id, obstruction_name, obstruction_desc, severity_level) VALUES
(1,  'Large Pothole',          'Deep pothole spanning majority of lane, wheelchair hazard', 3),
(2,  'Missing Curb Cut',       'No curb cut at intersection corner',                        3),
(3,  'Cracked Sidewalk Panel', 'Raised edge creates trip hazard',                           2),
(4,  'Gravel/Dirt Surface',    'Unpaved section impassable for wheelchairs',                3),
(5,  'Steep Incline >8%',      'Grade exceeds ADA maximum slope requirement',               2),
(6,  'Blocked Ramp',           'Construction materials blocking accessible ramp',           3),
(7,  'Narrow Sidewalk <36in',  'Sidewalk too narrow for standard wheelchair',               2),
(8,  'Ice Sheet',              'Uncleared ice covering full sidewalk width',                3),
(9,  'No Bike Lane',           'Street lacks any dedicated bike infrastructure',            1),
(10, 'Blocked Gate',           'Locked or obstructed gate on accessible route',            2),
(11, 'High Curb >0.5in',       'Curb height exceeds ADA allowable lip',                    2),
(12, 'Elevator Out of Service','MBTA elevator non-functional',                              3);
 
INSERT INTO location_obstruction (location_id, obstruction_id) VALUES
(1,  1),
(1,  2),
(2,  5),
(3,  9),
(4,  3),
(4,  8),
(5,  7),
(6,  4),
(7,  6),
(8,  11),
(9,  10),
(11, 12);
 
INSERT INTO disability_obstruction (disability_id, obstruction_id) VALUES
(1,1),(1,2),(1,3),(1,4),(1,5),(1,6),(1,7),(1,10),(1,11),
(2,2),(2,3),(2,8),
(5,1),(5,3),(5,8),
(6,1),(6,5),(6,8);
 
INSERT INTO `user` (user_id, first_name, last_name, user_email,
                   phone_number, preferred_language,
                   demographics_age, demographics_gender,
                   demographics_ethinicity) VALUES
(1,  'Paul',   'Baker',          'paul.baker@boston.gov',      '617-555-0101', 'English', 35, 'Male',   'White'),
(2,  'Wilson', 'Lampisyobiford', 'wilson.l@bostonability.org', '617-555-0102', 'English', 28, 'Male',   'Black'),
(3,  'Sally',  'Locke',          'sally.locke@gmail.com',      '617-555-0103', 'English', 54, 'Female', 'White'),
(4,  'John',   'Marcus',         'j.marcus@northeastern.edu',  '617-555-0104', 'English', 21, 'Male',   'Hispanic'),
(5,  'Aisha',  'Rahman',         'a.rahman@gmail.com',         '617-555-0105', 'English', 40, 'Female', 'South Asian'),
(6,  'Carlos', 'Vega',           'carlosvega@outlook.com',     '617-555-0106', 'Spanish', 33, 'Male',   'Hispanic'),
(7,  'Linda',  'Chen',           'linda.chen@bu.edu',          '617-555-0107', 'English', 27, 'Female', 'East Asian'),
(8,  'Marcus', 'Thompson',       'marcust@comcast.net',        '617-555-0108', 'English', 61, 'Male',   'Black'),
(9,  'Priya',  'Nair',           'priya.nair@mit.edu',         '617-555-0109', 'English', 29, 'Female', 'South Asian'),
(10, 'Derek',  'Sullivan',       'dsullivan@bostonpw.gov',     '617-555-0110', 'English', 45, 'Male',   'White');
 
INSERT INTO user_role (user_id, role_id) VALUES
(1,  2),
(2,  1),
(3,  3),
(4,  3),
(5,  3),
(6,  3),
(7,  4),
(8,  3),
(9,  2),
(10, 1);
 
INSERT INTO user_disability (user_id, disability_id) VALUES
(3, 1),
(3, 2),
(5, 1),
(8, 5);
 
INSERT INTO report (report_id, report_date, report_type, report_status,
                   past_report_status, urgency, description,
                   location_id, user_id) VALUES
(1,  '2026-01-05', 'accessibility',    'open',     NULL,   'High',   'Large pothole at Tremont and Worcester St — wheelchair got stuck',               1,  3),
(2,  '2026-01-08', 'accessibility',    'open',     NULL,   'High',   'Missing curb cut at Tremont and Shawmut intersection',                           1,  3),
(3,  '2026-01-10', 'accessibility',    'resolved', 'open', 'Medium', 'Steep incline on Boylston near Copley — no handrail present',                    2,  5),
(4,  '2026-01-12', 'snow_plow_request','open',     NULL,   'High',   'Unplowed Commonwealth Ave bike lane between Kenmore and Packards Corner',        3,  4),
(5,  '2026-01-15', 'accessibility',    'open',     NULL,   'Medium', 'Cracked sidewalk panel on Blue Hill Ave near Warren St',                         4,  8),
(6,  '2026-01-18', 'accessibility',    'resolved', 'open', 'Low',    'Narrow sidewalk on Centre St — barely passable with mobility aid',               5,  3),
(7,  '2026-01-20', 'accessibility',    'open',     NULL,   'High',   'Gravel surface on Dorchester Ave — impassable after rain',                       6,  5),
(8,  '2026-01-22', 'accessibility',    'open',     NULL,   'High',   'Construction materials blocking ramp on Washington St',                          7,  6),
(9,  '2026-01-25', 'snow_plow_request','resolved', 'open', 'High',   'Ice sheet covering Cambridge Street sidewalk near Packards',                     8,  4),
(10, '2026-01-28', 'accessibility',    'open',     NULL,   'Medium', 'Blocked gate on Meridian St accessible route',                                   9,  8),
(11, '2026-02-01', 'accessibility',    'open',     NULL,   'High',   'MBTA elevator on Huntington Ave Green Line stop out of service',                 11, 3),
(12, '2026-02-03', 'bike_theft',       'open',     NULL,   'Medium', 'Multiple bike thefts reported near Blue Hill Ave and Warren St intersection',    10, 4),
(13, '2026-02-05', 'accessibility',    'open',     NULL,   'Medium', 'High curb lip on Cambridge St — wheelchair wheel catches on edge',               8,  5),
(14, '2026-02-08', 'accessibility',    'resolved', 'open', 'Low',    'Icy and unplowed Hyde Park Ave sidewalk — reported cleared',                     12, 8),
(15, '2026-02-10', 'snow_plow_request','open',     NULL,   'High',   'Blue Hill Ave main roadway blocked with snow — primary resident route',          4,  4),
(16, '2026-02-12', 'accessibility',    'open',     NULL,   'High',   'No curb cut at Warren St and Blue Hill Ave intersection',                        10, 3),
(17, '2026-02-15', 'accessibility',    'open',     NULL,   'Medium', 'Broken sidewalk panel on Huntington Ave near Forsyth St',                        11, 6),
(18, '2026-02-18', 'accessibility',    'resolved', 'open', 'High',   'Blocked ramp near South End community center — confirmed cleared by crew',       1,  7),
(19, '2026-02-20', 'accessibility',    'open',     NULL,   'Low',    'Narrow path near Jamaica Plain public library entrance',                         5,  8),
(20, '2026-02-22', 'bike_theft',       'open',     NULL,   'Low',    'Bike rack on Boylston St near Copley frequently targeted — 2 thefts this month', 2,  4);
 
INSERT INTO accessibility_report (report_id, issue_type_id, report_date,
                                  report_status, photo_url, user_id) VALUES
(1,  1,  '2026-01-05', 'open',     'https://cdn.bostonability.org/photos/r1.jpg',  3),
(2,  2,  '2026-01-08', 'open',     'https://cdn.bostonability.org/photos/r2.jpg',  3),
(3,  5,  '2026-01-10', 'resolved', NULL,                                             5),
(5,  3,  '2026-01-15', 'open',     'https://cdn.bostonability.org/photos/r5.jpg',  8),
(6,  12, '2026-01-18', 'resolved', NULL,                                             3),
(7,  11, '2026-01-20', 'open',     'https://cdn.bostonability.org/photos/r7.jpg',  5),
(8,  6,  '2026-01-22', 'open',     'https://cdn.bostonability.org/photos/r8.jpg',  6),
(10, 12, '2026-01-28', 'open',     NULL,                                             8),
(11, 7,  '2026-02-01', 'open',     'https://cdn.bostonability.org/photos/r11.jpg', 3),
(13, 2,  '2026-02-05', 'open',     'https://cdn.bostonability.org/photos/r13.jpg', 5),
(16, 2,  '2026-02-12', 'open',     'https://cdn.bostonability.org/photos/r16.jpg', 3),
(17, 3,  '2026-02-15', 'open',     NULL,                                             6),
(18, 6,  '2026-02-18', 'resolved', 'https://cdn.bostonability.org/photos/r18.jpg', 7),
(19, 12, '2026-02-20', 'open',     NULL,                                             8);
 
INSERT INTO accessibility_ticket (ticket_id, ticket_status, ticket_date,
                                  ticket_time, report_id, issue_type_id) VALUES
(1,  'open',         '2026-01-05', '09:15:00', 1,  1),
(2,  'open',         '2026-01-08', '11:30:00', 2,  2),
(3,  'resolved',     '2026-01-10', '14:00:00', 3,  5),
(4,  'in_progress',  '2026-01-15', '08:45:00', 5,  3),
(5,  'resolved',     '2026-01-18', '10:00:00', 6,  12),
(6,  'open',         '2026-01-20', '13:20:00', 7,  11),
(7,  'high_priority','2026-01-22', '09:00:00', 8,  6),
(8,  'resolved',     '2026-01-25', '16:00:00', 9,  8),
(9,  'open',         '2026-01-28', '12:10:00', 10, 12),
(10, 'high_priority','2026-02-01', '08:30:00', 11, 7),
(11, 'open',         '2026-02-05', '14:45:00', 13, 2),
(12, 'high_priority','2026-02-12', '09:15:00', 16, 2),
(13, 'open',         '2026-02-15', '11:00:00', 17, 3),
(14, 'resolved',     '2026-02-18', '15:30:00', 18, 6),
(15, 'open',         '2026-02-20', '10:20:00', 19, 12);
