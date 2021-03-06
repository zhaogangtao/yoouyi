package com.yoouyi.dao.trip;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.bson.types.ObjectId;
import org.junit.BeforeClass;
import org.junit.Test;

import com.yoouyi.common.BaseTestCase;
import com.yoouyi.model.trip.RecentPO;

public class TestRecentDAO implements BaseTestCase {
    
    private static RecentDAO recentDAO;
    @BeforeClass
    public static void setUp() {
        
        recentDAO = (RecentDAO) acts.getBean("recentDAO");
    }    
    
    @Test
    public void testSave() {
        RecentPO recent = new RecentPO();
        recent.setCreateDate(new Date());
        
        ObjectId o = new ObjectId("546dd870081884d01208e939");
        recentDAO.save(recent);
    }
    
    @Test
    public void testFindOne() {
        ObjectId o = new ObjectId("546dd870081884d01208e939");
        RecentPO recent = (RecentPO) recentDAO.findOne(o);
        System.out.println(recent.getTrip());
    }
    
    @Test
    public void testFindAll() {
        List<RecentPO> result = new ArrayList<RecentPO>();
        result = recentDAO.findAll("546aafbe3b9cd01c46958c10");
        
        System.out.println(result.size());
    }

}
