#include "CourseService.h"

#include <transport/TSocket.h>
#include <transport/TBufferTransports.h>
#include <protocol/TBinaryProtocol.h>

#include <vector>
#include <string>
#include <algorithm>
#include <iterator>

using namespace std;

using namespace apache::thrift;
using namespace apache::thrift::protocol;
using namespace apache::thrift::transport;

using namespace thrift::client;

ostream& operator << (ostream & o, const Phone& p)
{
    o << "***" << endl;
    o << p.type << " " << p.number << endl;
    o << "***" << endl;
    return o;
}

ostream& operator << (ostream & o, const Person& p)
{
    o << "Person Name:" << p.lastName + p.firstName << endl;
    o << "Email is " << p.email << endl;
    o << "Phones:" << endl;
    for(int i = 0; i < p.phones.size(); i++)
    {
        o << p.phones[i];
    }
    return o;
}

ostream& operator << (ostream & o,const Course& c)
{
    o << "Course ID: " << c.id << endl;
    o << "Course Number: " << c.number << endl;
    o << "Course Name: " << c.name << endl;
    o << "Course Room: " << c.roomNumber << endl;
    o << "Course Instructor: " << c.instructor << endl;
    o << "Course Students: " << endl;
    for(int i = 0; i < c.students.size(); i++)
    {
        o << c.students[i];
    }
    return o;
}

int main(int argc, char **argv) {
  boost::shared_ptr<TSocket> socket(new TSocket("localhost", 9090));
  boost::shared_ptr<TTransport> transport(new TBufferedTransport(socket));
  boost::shared_ptr<TProtocol> protocol(new TBinaryProtocol(transport));

  CourseServiceClient client(protocol);
  transport->open();
  vector<string> vec;
  client.getCourseInventory(vec);
  transport->close();
  copy(vec.begin(),vec.end(),ostream_iterator<string>(cout," "));
  cout << endl;

  transport->open();
  Course c;
  client.getCourse(c,"10001");
  cout << c << endl;
  client.addCourse(c);
  transport->close();
  return 0;
}
