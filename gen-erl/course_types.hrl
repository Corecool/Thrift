-ifndef(_course_types_included).
-define(_course_types_included, yeah).

-define(course_PhoneType_HOME, 0).
-define(course_PhoneType_WORK, 1).
-define(course_PhoneType_MOBILE, 2).
-define(course_PhoneType_OTHER, 3).

%% struct phone

-record(phone, {id = undefined :: integer(), 
                number = undefined :: string(), 
                type = undefined :: integer()}).

%% struct person

-record(person, {id = undefined :: integer(), 
                 firstName = undefined :: string(), 
                 lastName = undefined :: string(), 
                 email = undefined :: string(), 
                 phones = [] :: list()}).

%% struct course

-record(course, {id = undefined :: integer(), 
                 number = undefined :: string(), 
                 name = undefined :: string(), 
                 instructor = #person{} :: #person{}, 
                 roomNumber = undefined :: string(), 
                 students = [] :: list()}).

%% struct courseNotFound

-record(courseNotFound, {message = undefined :: string()}).

%% struct unacceptableCourse

-record(unacceptableCourse, {message = undefined :: string()}).

-endif.
