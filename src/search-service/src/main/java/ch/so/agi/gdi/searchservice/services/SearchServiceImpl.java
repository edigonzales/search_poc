package ch.so.agi.gdi.searchservice.services;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.jdbc.core.namedparam.SqlParameterSource;
import org.springframework.stereotype.Service;

import ch.so.agi.gdi.searchservice.models.SearchResult;

@Service
public class SearchServiceImpl implements SearchService {
    private final Logger log = LoggerFactory.getLogger(this.getClass());

    @Autowired
    private NamedParameterJdbcTemplate jdbcTemplate;

    @Override
    public List<SearchResult> getResultByString(String searchText) {
        String sql = "SELECT tok3(:searchText) as aresult;";
        
        RowMapper<SearchResult> rowMapper = new BeanPropertyRowMapper<SearchResult>(SearchResult.class);
        SqlParameterSource namedParameters = new MapSqlParameterSource().addValue("searchText", searchText);
        List<SearchResult> resultList = jdbcTemplate.query(sql, namedParameters, rowMapper);

        return resultList;        
    }

}
