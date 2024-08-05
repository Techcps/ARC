

gcloud auth list

gcloud config set compute/region $REGION

export PROJECT_ID=$DEVSHELL_PROJECT_ID

mkdir techcps && cd techcps


cat > Function.cs <<'EOF_CP'
using Google.Cloud.Functions.Framework;
using Microsoft.AspNetCore.Http;
using System.Threading.Tasks;

namespace HelloWorld;

public class Function : IHttpFunction
{
    public async Task HandleAsync(HttpContext context)
    {
        await context.Response.WriteAsync("Hello World!", context.RequestAborted);
    }
}
EOF_CP

cat > HelloHttp.csproj <<'EOF_CP'
<Project Sdk="Microsoft.NET.Sdk">
  <PropertyGroup>
    <OutputType>Exe</OutputType>
    <TargetFramework>net6.0</TargetFramework>
  </PropertyGroup>

  <ItemGroup>
    <PackageReference Include="Google.Cloud.Functions.Hosting" Version="2.2.1" />
  </ItemGroup>
</Project>
EOF_CP


sleep 15

#!/bin/bash

deploy_function() {
  gcloud functions deploy cf-demo \
    --gen2 \
    --entry-point=HelloWorld.Function \
    --runtime=dotnet6 \
    --region=$REGION \
    --source=. \
    --trigger-http \
    --allow-unauthenticated \
    --quiet
}

deploy_success=false

while [ "$deploy_success" = false ]; do
  if deploy_function; then
    echo "Function deployed successfully (https://www.youtube.com/@techcps).."
    deploy_success=true
  else
    echo "please subscribe to techcps (https://www.youtube.com/@techcps)."
    sleep 10
  fi
done  


echo "Congratulations, you're all done with the lab"
echo "Please like share and subscribe to techcps(https://www.youtube.com/@techcps)..."

