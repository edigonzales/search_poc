package ch.so.agi.gdi.searchservice.services;

import java.util.List;

import ch.so.agi.gdi.searchservice.models.SearchResult;

public interface SearchService {
    List<SearchResult> getResultByString(String searchText);
}
