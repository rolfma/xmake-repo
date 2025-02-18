package("rapidjson")

    set_homepage("https://github.com/Tencent/rapidjson")
    set_description("RapidJSON is a JSON parser and generator for C++.")

    set_urls("https://github.com/Tencent/rapidjson/archive/$(version).zip",
             "https://github.com/Tencent/rapidjson.git")

    add_versions("v1.1.0", "8e00c38829d6785a2dfb951bb87c6974fa07dfe488aa5b25deec4b8bc0f6a3ab")
    -- This commit is used in arrow 7.0.0 https://github.com/apache/arrow/blob/release-7.0.0/cpp/thirdparty/versions.txt#L80
    add_versions("v1.1.0-arrow", "1a803826f1197b5e30703afe4b9c0e7dd48074f5")

    on_install(function (package)
        os.cp(path.join("include", "*"), package:installdir("include"))
    end)

    on_test(function (package)
        assert(package:check_cxxsnippets({test = [[
            void test()
            {
                const char* json = "{\"project\":\"rapidjson\",\"stars\":10}";
                rapidjson::Document d;
                d.Parse(json);

                rapidjson::StringBuffer buffer;
                rapidjson::Writer<rapidjson::StringBuffer> writer(buffer);
                d.Accept(writer);
            }
        ]]}, {configs = {languages = "c++11"}, includes = { "rapidjson/document.h", "rapidjson/stringbuffer.h", "rapidjson/writer.h"} }))
    end)
