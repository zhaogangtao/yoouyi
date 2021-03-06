package com.yoouyi.dao.user;

import java.util.Date;

import org.junit.BeforeClass;
import org.junit.Test;

import com.yoouyi.common.BaseTestCase;
import com.yoouyi.dao.user.FavoriteDAO;
import com.yoouyi.model.user.FavoritePO;

public class TestFavoriteDAO implements BaseTestCase {

    private static FavoriteDAO favoriteDAO;

    @BeforeClass
    public static void setUp() {

        favoriteDAO = (FavoriteDAO) acts.getBean("favoriteDAO");
    }

    @Test
    public void testSave() {
        
        FavoritePO favoritePO = new FavoritePO();
        
        favoritePO.setCreateDate(new Date());
        
        favoriteDAO.save(favoritePO);

    }

}
