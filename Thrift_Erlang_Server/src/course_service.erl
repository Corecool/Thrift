-module(course_service).

-include("courseService_thrift.hrl").
-include("course_types.hrl").

-export([start_link/0, stop/1,
         handle_function/2,
	 getCourseInventory/0,
	 getCourse/1,
	 addCourse/1
% Thrift implementations
% FILL IN HERE
         ]).

%%%%% EXTERNAL INTERFACE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

start_link() ->
    thrift_server:start_link(get_port(), courseService_thrift, ?MODULE).

stop(Server) ->
    thrift_server:stop(Server),
    ok.

%%%%% THRIFT INTERFACE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

handle_function(Function, Args) when is_atom(Function), is_tuple(Args) ->
    case apply(?MODULE, Function, tuple_to_list(Args)) of
        ok -> ok;
        Reply -> {reply, Reply}
    end.

getCourseInventory() ->    
    ["abc","123"].

getCourse(CourseNumber) ->
    HomePhone = #phone{id = 0, number = "12345678",
		       type = ?course_PhoneType_HOME},
    MobilePhone = #phone{id = 1, number = "12345678901",
			 type = ?course_PhoneType_MOBILE},
    Teacher = 
	#person{id = 0,firstName = "Chen",lastName = "Li",
		email = "test@126.com",
		phones = [HomePhone,MobilePhone]},
    NewCourseNumber = integer_to_list(
			list_to_integer(
			  binary_to_list(CourseNumber)) + 1),
    #course{id = 1,number = NewCourseNumber,
	    name = "Math",
	    roomNumber = "321",instructor = Teacher}.
    
addCourse(Course) ->
    io:format("Course is ~p~n",[Course]),
    io:format("CourseName is ~p~n",
	      [binary_to_list(Course#course.name)]),
    Instructor = Course#course.instructor,
    io:format("Teacher is ~p~n",[Instructor]).

%%%%% HELPER FUNCTIONS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

get_port() ->
    {ok, Result} = application:get_env(course, service_port),
    Result.


