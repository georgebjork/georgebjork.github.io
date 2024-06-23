---
title: Creating a Jekyll Site with Bootstrap
date: 2024-06-22 12:00:00 -0500
categories: [tutorials, project-setup]
tags: [bootstrap, jekyll]
image:
  path: /images/2024-06-22-jekyll-bootstrap/jekyll-logo.png
---

Recently, I was wanting to migrate a [webapp](https://github.com/georgebjork/LeviathanRipBlog) I had built to a static website. This never needed to be a webapp, and was totally overengineered for what it did. However, it was fun and it worked great. But, I don't want to pay the 5 bucks to host it anymore for the usage it got.

Enter Jekyll. Jekyll is something that had been on my radar for a while, and something I wanted to dip my toes into. I first started with this website, and getting this template up and running. After seeing how powerful Jekyll and static sites were, I decided to go head first into migrating my webapp to it.

My goal was to keep the feel of the site as close as possible to the original. This meant I was going to have to set up Bootstrap. After a few hours of research and trial and error, I finally got it set up. Below is how I set it up and what I learned. 🙂

You can find all of the code shown off in this blog [here](https://github.com/georgebjork/jekyll-bootstrap).

### Creating our Project 

To begin, create the project directory and initialize a blank Jekyll project with these commands:

```
mkdir jekyll-bootstrap
jekyll new jekyll-bootstrap --blank
```

Open the project in your development environment and start the Jekyll server:

```
jekyll serve
```

![Default Project](/images/2024-06-22-jekyll-bootstrap/first-build.png)
_This is the expected initial output._

Next, create a `.gitignore` file and include the following entries to ignore common directories and files:

```
_site/
.sass-cache/
.jekyll-cache/
.jekyll-metadata
# Ignore folders generated by Bundler
.bundle/
vendor/
```

Create an `index.html` file in the project root and remove the existing `index.md` file.

### Configure our Project for Bootstrap

Bootstrap integration is facilitated by Jekyll's built-in support for Sass (Syntactically Awesome Style Sheets).

Specify the location of the Sass files in the `config.yml` file:

```yaml
sass:
    load_paths: 
        - _sass
```

### Adding Bootstrap
Download the Bootstrap source files from [https://getbootstrap.com/docs/5.3/getting-started/download/](https://getbootstrap.com/docs/5.3/getting-started/download/) and unzip the package into the `_sass` directory of your Jekyll project. I'd recommend to include the entire Bootstrap directory for easier management.

Your Jekyll project structure should now look like this:

```
jekyll_bootstrap_project
┣ 📁 _data
┣ 📁 _includes
┣ 📁 _layouts
┣ 📁 _posts
┣ 📁 _sass
┃ ┗ 📁 bootstrap-5.3.3
┣ 📁 _site
┣ 📁 assets
┃ ┗ 📁 css
┃   ┗ 📃 styles.scss
┣ 📃 _config.yml
┣ 📃 .gitignore
┗ 📃 index.html
```

### More Configuration 

We want to ensure Bootstrap Sass files are included in the main `scss` file of your project. Create `styles.scss` in `assets/css`, and in the file add:

```scss
---
---

@import "main";
```

Then moving to our `_sass` directory, create these two file:
- `main.scss`
- `vars.scss`

In the main.scss, addd this code:

```scss
@import "vars";
@import "bootstrap-5.3.3/scss/bootstrap.scss";

/* Custom Styles */
```

Use `vars.scss` to override Bootstrap styles as needed. 

Now, our updated project structure should be:

```
jekyll_bootstrap_project
 ┣ 📁 _data
 ┣ 📁 _includes
 ┣ 📁 _layouts
 ┣ 📁 _posts
 ┣ 📁 _sass
 ┃ ┗ 📁 bootstrap-5.3.3
 ┃ ┗ 📃 main.scss
 ┃ ┗ 📃 vars.scss
 ┣ 📁 _site
 ┣ 📁 assets
 ┃ ┗ 📁 css
 ┃   ┗ 📃 styles.scss
 ┣ 📃 _config.yml
 ┣ 📃 .gitignore
 ┗ 📃 index.html
```

Now, update the `default.html` layout file in the `_layouts` folder by replacing the stylesheet link with:

```html
<link rel="stylesheet" href="/assets/css/styles.css">
```

And thats it, we've now added bootstrap to our jekyll project!

### Final Set Up

Before running the project, update the `index.html` with:
```
---
layout: home
# Index page
---
```

In our `layouts` folder, create a file called, `home.html`. This will be our home layout and where the application will land by default. Add this at the start of our file:

```html
---
layout: default
# Home Page
---

```

Now, we can add some basic html + bootstrap code such as:

```html
<div class="container">
  <button class="btn btn-primary">Hello World</button>
</div>
```

And thats it! Now we can run our application with `jekyll serve` again. If everything has been set up properly, we should see this:

![Final Result](/images/2024-06-22-jekyll-bootstrap/final-result.png)
_Our Final Result_

And just like that, we have added bootstrap and to our jekyll site!
