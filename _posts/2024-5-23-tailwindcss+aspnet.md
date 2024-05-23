---
title: Tailwind + ASP.NET
date: 2024-05-23 12:00:00 -500
categories: [tutorials, project-setup]
tags: [tailwindcss, aspnet, dotnet]
image:
  path: /images/2024-5-23-tailwindcss+aspnet/header1.png
---

By default, an ASP.NET project comes with Bootstrap 5 pre-installed. Bootstrap is a great way to get a clean UI (with dark mode) right out of the box. However, some projects require some more flexibility than what Bootstrap can offer. Here is how you can get Tailwind set up in your ASP.NET project.

NOTE: This tutorial assumes you already have basic knowledge of creating and running ASP.NET apps.

## Requirements
- [NodeJS](https://nodejs.org/en) (If you are on Mac or Linux, [NVM](https://github.com/nvm-sh/nvm) is a great and easy option to get Node)
- [.NET 8](https://dotnet.microsoft.com/en-us/download/dotnet/8.0) (This does work with .NET 6 as well)
- Visual Studio/Rider/VS Code

## Creating our project

To create our project run this in our project directory.
```
dotnet new mvc -n aspnet-tailwind
```

Run our project with to test to make sure everything is working.
```
dotnet run
```

![Example App](/images/2024-5-23-tailwindcss+aspnet/first-run.png)
_This is what we should see._


## Adding Tailwind

In our project directory, run:
```
npm init -y
```

You should see the package.json file.
```
Wrote to {your-path}\aspnet-tailwind\package.json:

{
 "name": "aspnet-tailwind",
 "version": "1.0.0",
 "description": "",
 "main": "index.js",
 "scripts": {
  "test": "echo \"Error: no test specified\" && exit 1"
 },
 "keywords": [],
 "author": "",
 "license": "ISC"
}
```

Now, run this command:
```
npm install -D tailwindcss
```

And add this script to our package.json:
```
"scripts": {
  "css:build": "npx tailwindcss -i ./wwwroot/css/site.css -o ./wwwroot/css/styles.css --minify"
 }
```
This command will be called to build all of our tailwind styles.

Now, we need to create our tailwind config file. To do so, run this command:
```
npx tailwindcss init
```
Now we should see a tailwind.config.js in our project root directory. 

In that file, overwrite "module.exports = {..." with:

```
module.exports = {
  content: [
    './Pages/**/*.cshtml',
    './Views/**/*.cshtml'
],
  theme: {
    extend: {},
  },
  plugins: [],
}
```

What this does is tell tailwind at which directories should it build its css from. So in this case, it will look in the Pages and View folders for anything with a .cshtml ending. If you are using `Areas`, then you will also need them for this also. 

```
'./Areas/**/Views/**/*.cshtml',
'./Areas/**/Pages/**/**/*.cshtml'
```

The first line will handle your typical Views folder in an area, and the second line will handle any scaffolded identity if you have any.

Now, let's move to our `wwwroot/css`. Remove all code inside of it and replace it with:
```
@tailwind base;
@tailwind components;
@tailwind utilities;
```

Afterwards, move to your `.csproj` file and add:

```
<ItemGroup>
 <UpToDateCheckBuilt Include="wwwroot/css/site.css" Set="Css" />
 <UpToDateCheckBuilt Include="tailwind.config.js" Set="Css" />
</ItemGroup>

<Target Name="Tailwind" BeforeTargets="Build">
 <Exec Command="npm run css:build"/>
</Target>
```

This final line will run our `css:build` command we added earlier in our package.json.

Finally, we can add this to our `_Layout.cshtml`. You will want to add this to any other `_Layouts.cshtml`'s you may have in our project.

```
<link rel="stylesheet" href="~/css/styles.css" asp-append-version="true" />
```

## Removing Bootstrap
Now that all of the tailwind is added, we want to now remove any and all Bootstrap that came with the project.

### Place 1: wwwroot

In our wwwroot/lib you should see a bootstrap folder. Feel free to delete that folder.

![Place 1](/images/2024-5-23-tailwindcss+aspnet/boostrap-place1.png)

### Place 2: _Layout.cshtml

In our `_Layout.cshtml` you should see places at the top and bottom of your page. Refer to the images below of what to remove:

![Place 2](/images/2024-5-23-tailwindcss+aspnet/boostrap-place2.png)
_In your header_

![Place 2.1](/images/2024-5-23-tailwindcss+aspnet/boostrap-place2-1.png)
_In your script tags_

## Adding Tailwind Code

Now that tailwind is added and bootstrap is removed. Lets change our `_Layout.cshtml` and a view to test this.

In our `Layout.cshtml`, replace this default code:

```
<header>
  <nav class="navbar navbar-expand-sm navbar-toggleable-sm navbar-light bg-white border-bottom box-shadow mb-3">
    <div class="container-fluid">
      <a class="navbar-brand" asp-area="" asp-controller="Home" asp-action="Index">aspnet_tailwind</a>
      <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target=".navbar-collapse" aria-controls="navbarSupportedContent"
          aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="navbar-collapse collapse d-sm-inline-flex justify-content-between">
        <ul class="navbar-nav flex-grow-1">
          <li class="nav-item">
            <a class="nav-link text-dark" asp-area="" asp-controller="Home" asp-action="Index">Home</a>
          </li>
          <li class="nav-item">
            <a class="nav-link text-dark" asp-area="" asp-controller="Home" asp-action="Privacy">Privacy</a>
          </li>
        </ul>
      </div>
    </div>
  </nav>
</header>
<div class="container">
  <main role="main" class="pb-3">
    @RenderBody()
  </main>
</div>
<footer class="border-top footer text-muted">
  <div class="container">
    &copy; 2024 - aspnet_tailwind - <a asp-area="" asp-controller="Home" asp-action="Privacy">Privacy</a>
  </div>
</footer>

```

With this new code:

```
<header class="bg-blue-600 text-white p-4">
  <h1 class="text-3xl">My Website</h1>
</header>
<nav class="bg-blue-500 text-white p-2">
  <ul class="flex space-x-4">
    <li><a href="#" class="hover:underline">Home</a></li>
    <li><a href="#" class="hover:underline">About</a></li>
    <li><a href="#" class="hover:underline">Services</a></li>
    <li><a href="#" class="hover:underline">Contact</a></li>
  </ul>
</nav>
<main class="p-4">
  <div id="content">
    @RenderBody()
  </div>
</main>

<footer class="bg-blue-600 text-white p-4 mt-4">
  <p>&copy; 2024 My Website</p>
</footer>
```

Then, in our `Home/Index.cshtml` view, we can add a tailwind button. 

```
<button class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded">
 Button
</button>
```

## Running the app

Now with everything installed and added, running 

```
dotnet run
```

should yield us this screen:

![Final Product](/images/2024-5-23-tailwindcss+aspnet/tailwind-final.png)
_Our final product_

Now we have an ASP.NET app with tailwind!


## Bonus: DaisyUI

If writing pure Tailwind isn't your cup of tea, we can take this one step further and add [DaisyUI](https://daisyui.com/) in about 30 seconds. 

First, in the root of your project run the command:

```
npm i -D daisyui@latest
```

Then in our `tailwind.config.js` add this line of code:

```
plugins: [
  require('daisyui'),
 ],
```

And that's it! DaisyUI is now installed. 

Navigating back to our `_Layout.cshtml`, let's change our base layout a bit to this:

```
 <header class="navbar bg-primary text-primary-content">
    <div class="flex-1">
      <a class="btn btn-ghost normal-case text-xl">My Website</a>
    </div>
    <nav class="flex-none">
      <ul class="menu menu-horizontal p-0">
        <li><a>Home</a></li>
        <li><a>About</a></li>
        <li><a>Services</a></li>
        <li><a>Contact</a></li>
      </ul>
    </nav>
  </header>
  <main class="p-4">
    <div id="content" class="container mx-auto">
      @RenderBody()
    </div>
  </main>
  <footer class="footer footer-center p-4 bg-primary text-primary-content">
    <div>
      <p>&copy; 2024 My Website</p>
    </div>
  </footer>
```

And now in our `Home/Index.cshtml` view, we can add a daisyui button. 

```
<button class="btn btn-primary">Button</button>
```

With that added, run our project and we should see this now!

![Final Product](/images/2024-5-23-tailwindcss+aspnet/daisyui-final.png)
_daisyui final product_


## Conclusion

And just like that, we have added tailwindcss and daisyui to our ASP.NET application!