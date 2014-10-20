package com.zgt.dao.travel;

import java.util.Collections;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.stereotype.Repository;

import com.mongodb.BasicDBObject;
import com.mongodb.DBCollection;
import com.zgt.common.Constants;
import com.zgt.model.mongo.TravelInfo;

@Repository("travelLineDAO")
public class TravelLineDAO {

    private MongoTemplate mongoTemplate;

    public MongoTemplate getMongoTemplate() {
        return mongoTemplate;
    }

    @Resource
    public void setMongoTemplate(MongoTemplate mongoTemplate) {
        this.mongoTemplate = mongoTemplate;
    }

    public void insert(TravelInfo travelLinePO) {
        mongoTemplate.insert(travelLinePO);
    }
    
    
    public List<TravelInfo> getTravelLine(Integer pageNum, String starting, String destination, Date travelTime) {
        
        Query query = createQuery(pageNum, destination);
        
        return mongoTemplate.find(query, TravelInfo.class);  
    }

    private Query createQuery(Integer pageNum, String destination) {
        Criteria travelLineCriteria = Criteria.where("destination").is(destination);
        
        Query query = new Query(travelLineCriteria);
        
        if (pageNum != null) {
            query.skip((pageNum - 1 ) * Constants.PAGE_SIZE);
            query.limit(Constants.PAGE_SIZE);
        }
        return query;
    }

    public int count(String destination) {
        Query query = createQuery(null, destination);
        return (int) mongoTemplate.count(query, TravelInfo.class);
    }
    
    public List<String> getAllTravelTime(String destination) {
        BasicDBObject whereQuery = new BasicDBObject();
        whereQuery.put("destination", destination);
        
        DBCollection query= mongoTemplate.getCollection("travelInfo");
        List<String> result = query.distinct("port", whereQuery);
        return result;
    }

    public List<String> getAllTravelPlatForm(String destination) {
        BasicDBObject whereQuery = new BasicDBObject();
        whereQuery.put("destination", destination);

        DBCollection query= mongoTemplate.getCollection("travelInfo");
        List<String> result = query.distinct("platform", whereQuery);
        return result;
    }

}