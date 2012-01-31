app = Rack::Builder.new do
   use Middleware::Example
   use Rack::CommonLogger
   use Rack::ShowExceptions
end

Rack::Handler::Puma.run(app)

