#-------------------------------------------------
#
# Project created by QtCreator 2011-09-03T20:14:03
#
#-------------------------------------------------

QT       += core

QT       -= gui

TARGET = Thrift_CPlusPlus_Client
CONFIG   += console
CONFIG   -= app_bundle

TEMPLATE = app

HEADERS += CourseService.h \
    course_types.h \
    course_constants.h
SOURCES += main.cpp \
    CourseService.cpp \
    course_types.cpp \
    course_constants.cpp

INCLUDEPATH = /opt/thrift-0.7.0/include/thrift /opt/boost_1_47_0/include
LIBS += -L/opt/thrift-0.7.0/lib -lthrift
