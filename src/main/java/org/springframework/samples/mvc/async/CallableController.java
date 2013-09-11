package org.springframework.samples.mvc.async;

import java.util.List;
import java.util.Locale;
import java.util.concurrent.Callable;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.async.WebAsyncTask;

import com.dropbox.core.*;


@Controller
@RequestMapping("/async/callable")
public class CallableController {
	
	 // Get your app key and secret from the Dropbox developers website.
    final String APP_KEY = "h6oeblm6hp2oa2w";
    final String APP_SECRET = "dbpm5vd76249km1";
    
    public CallableController() {
    	//initialise dropbox
    	try {
    	System.out.println("initialise dropbox");
    	DbxAppInfo appInfo = new DbxAppInfo(APP_KEY, APP_SECRET);

        DbxRequestConfig config = new DbxRequestConfig("JavaTutorial/1.0",
            Locale.getDefault().toString());
        DbxWebAuthNoRedirect webAuth = new DbxWebAuthNoRedirect(config, appInfo);

        // Have the user sign in and authorize your app.
        String authorizeUrl = webAuth.start();
        System.out.println("1. Go to: " + authorizeUrl);
        //System.out.println("2. Click "Allow" (you might have to log in first)");
        System.out.println("3. Copy the authorization code.");
        String code = "ZgPhOe3mmuwAAAAAAAAAAQUeS1GUw9N94eDBlYi8E_g";
     // This will fail if the user enters an invalid authorization code.
        //DbxAuthFinish authFinish = webAuth.finish(code);
        //System.out.println(authFinish.accessToken);
        DbxClient client = new DbxClient(config, "9X0ZpzMY5xUAAAAAAAAAAYc7hP_-4Ci_Isq99XUUIPRnvuzGjBdPhMdq4GOEYo0Q");

        System.out.println("Linked account: " + client.getAccountInfo().displayName);
        
        client.createFolder("/YetAnotherGM_Files");
        
        DbxEntry.WithChildren listing = client.getMetadataWithChildren("/YetAnotherGM_Files");
        System.out.println("Files in the folder:");
        listChildren(listing.children);
        
    	} catch (Exception e) {
    		e.printStackTrace();
    	}
    }
    
    public void listChildren(List<DbxEntry> parent) {
    	for (DbxEntry child : parent) {
            System.out.println("	" + child.name + ": " + child.toString());
            /*if (child.isFolder()) {
            	listChildren(child.)
            }*/
        }
    }
    
	@RequestMapping("/opengmk")
	public @ResponseBody Callable<String> openGMK() {

		return new Callable<String>() {
			@Override
			public String call() throws Exception {
				Thread.sleep(2000);
				return "Opened GMK :)";
			}
		};
	}

	@RequestMapping("/response-body")
	public @ResponseBody Callable<String> callable() {

		return new Callable<String>() {
			@Override
			public String call() throws Exception {
				Thread.sleep(2000);
				return "Callable result";
			}
		};
	}

	@RequestMapping("/view")
	public Callable<String> callableWithView(final Model model) {

		return new Callable<String>() {
			@Override
			public String call() throws Exception {
				Thread.sleep(2000);
				model.addAttribute("foo", "bar");
				model.addAttribute("fruit", "apple");
				return "views/html";
			}
		};
	}

	@RequestMapping("/exception")
	public @ResponseBody Callable<String> callableWithException(
			final @RequestParam(required=false, defaultValue="true") boolean handled) {

		return new Callable<String>() {
			@Override
			public String call() throws Exception {
				Thread.sleep(2000);
				if (handled) {
					// see handleException method further below
					throw new IllegalStateException("Callable error");
				}
				else {
					throw new IllegalArgumentException("Callable error");
				}
			}
		};
	}

	@RequestMapping("/custom-timeout-handling")
	public @ResponseBody WebAsyncTask<String> callableWithCustomTimeoutHandling() {

		Callable<String> callable = new Callable<String>() {
			@Override
			public String call() throws Exception {
				Thread.sleep(2000);
				return "Callable result";
			}
		};

		return new WebAsyncTask<String>(1000, callable);
	}

	@ExceptionHandler
	@ResponseBody
	public String handleException(IllegalStateException ex) {
		return "Handled exception: " + ex.getMessage();
	}

}
