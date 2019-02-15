package ch.so.agi.gdi.searchservice.jsf;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import javax.faces.view.ViewScoped;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import ch.so.agi.gdi.searchservice.models.SearchResult;
import ch.so.agi.gdi.searchservice.services.SearchServiceImpl;

@ViewScoped
@Component
public class SearchView implements Serializable {
    private static final long serialVersionUID = 1L;

    private final Logger log = LoggerFactory.getLogger(this.getClass());

    @Autowired
    private SearchServiceImpl searchService;
    
    private String txt1;
    
    public List<String> completeText(String query) {
        List<String> results = new ArrayList<String>();
        for(int i = 0; i < 10; i++) {
            //results.add(query + i);
        }
         
        List<SearchResult> searchResultList = searchService.getResultByString(query); 
        for (SearchResult searchResult : searchResultList) {
            //log.info(searchResult.getaResult());
            
            String[] parts =  searchResult.getaResult().split("\\|");
            String result = parts[0].substring(2).trim();
//            log.info(result);
            
            results.add(result);
//            results.add(searchResult.getaResult());
        }

        return results;
    }
    
    public String getTxt1() {
        return txt1;
    }
 
    public void setTxt1(String txt1) {
        this.txt1 = txt1;
    }
}
