#include <iostream>
#include "NginxLexer.h"
#include "antlr4-runtime.h"
#include "NginxParser.h"
#include <string>

using namespace std;
using namespace antlr4;
using namespace parsers;

void test(const string &s) {
    cout << "当前测试字符串：" << s << endl;
    // S1
    ANTLRInputStream input(s);
    // S2
//    ANTLRInputStream input("http{}");
    // S3
//    ANTLRInputStream input("location = / {}");

    NginxLexer lexer(&input);
    CommonTokenStream tokens(&lexer);

    tokens.fill();
    for (auto token : tokens.getTokens()) {
        cout << token->toString() << endl;
    }

    NginxParser parser(&tokens);
    tree::ParseTree *tree = parser.input();

    cout << tree->toStringTree(&parser) << endl << endl;
}

int main() {
//    vector<string> s1TestCases = {
//            "server foo;",
//            "server_name_value foo.com;",
//            "server_name Foocom;",
//            "server_name FOOCOM;",
//            "server_name F;",
//            "server_name f;",
//            "server_name Foo.com;",
//            "server_name _foo.com;",
//            "server_name _foo123.com;",
//            "server_name _;",
//    };
//
//    for (auto s : s1TestCases) {
//        test(s);
//    }

    ifstream fs("/home/fifilyu/workspace/warp-drive-tech/antlr/nginx_demo/test.conf");

    stringstream ss;
    string line;
    while (getline(fs, line)) {
        ss << line;
    }

    const string content = ss.str();

    test(content);


    return 0;
}
