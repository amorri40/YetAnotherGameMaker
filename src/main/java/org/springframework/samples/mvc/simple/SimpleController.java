package org.springframework.samples.mvc.simple;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class SimpleController {
	
	boolean shouldLoop=false;

	@RequestMapping("/simple")
	public @ResponseBody String simple() {
		/*while (shouldLoop) {
			try {
				//Thread.sleep(100000);
				int i = 0;
				i++;
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}*/
		return "Hello world! Just got simpler!y";
	}

}
