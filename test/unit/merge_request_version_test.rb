# encoding: utf-8
#--
#   Copyright (C) 2009 Nokia Corporation and/or its subsidiary(-ies)
#
#   This program is free software: you can redistribute it and/or modify
#   it under the terms of the GNU Affero General Public License as published by
#   the Free Software Foundation, either version 3 of the License, or
#   (at your option) any later version.
#
#   This program is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU Affero General Public License for more details.
#
#   You should have received a copy of the GNU Affero General Public License
#   along with this program.  If not, see <http://www.gnu.org/licenses/>.
#++


require File.dirname(__FILE__) + '/../test_helper'

class MergeRequestVersionTest < ActiveSupport::TestCase
  context 'In general' do
    setup do
      @merge_request = merge_requests(:moes_to_johans)
      @merge_request.stubs(:calculate_merge_base).returns("ffcca0")
      @first_version = @merge_request.create_new_version
    end

    should 'ask the target repository for commits' do
      repo = mock("Tracking git repo")
      repo.expects(:commits_between).with(
        @first_version.merge_base_sha,
        @merge_request.merge_branch_name(@first_version.version)
      ).returns([])
      tracking_repo = mock("Tracking repository")
      tracking_repo.stubs(:id).returns(999)
      tracking_repo.stubs(:git).returns(repo)
      @merge_request.stubs(:tracking_repository).returns(tracking_repo)
      @first_version.stubs(:merge_request).returns(@merge_request)
      result = @first_version.affected_commits
    end

    should 'cache affected_commits' do
      @first_version.stubs(:cache_key).returns('cache')
      Rails.cache.expects(:fetch).with('cache', :expires_in => 60.minutes).returns([])
      result = @first_version.affected_commits
    end

    should "have a unique cache key between versions" do
      second_version = @merge_request.create_new_version
      assert_equal "commits_in_merge_request_version_#{second_version.id}", second_version.cache_key
    end
  end

  context 'Diff browsing' do
    setup do
      @merge_request = merge_requests(:moes_to_johans)
      @merge_request.stubs(:calculate_merge_base).returns("ffcca0")
      @version = @merge_request.create_new_version
      @diff_backend = mock
      @version.stubs(:diff_backend).returns(@diff_backend)
    end
    
    should 'handle a range' do
      @diff_backend.expects(:commit_diff).with("ffc","ccf")
      result = @version.diffs("ffc".."ccf")
    end

    should 'handle a single commit' do
      @diff_backend.expects(:single_commit_diff).with("ffc")
      result = @version.diffs("ffc")      
    end

    should 'handle all commits' do
      @diff_backend.expects(:commit_diff).with(@version.merge_base_sha, @merge_request.ending_commit)
      result = @version.diffs
    end
  end

  context "The diff backend" do
    setup {
      @backend = MergeRequestVersion::DiffBackend.new(nil)
    }

    should "have a cache key" do
      assert_equal "merge_request_diff_ff0_cc9", @backend.cache_key("ff0", "cc9")
      assert_equal "merge_request_diff_ff0", @backend.cache_key("ff0")
    end

    should "ask the cache for diffs for a range of commits" do
      Rails.cache.expects(:fetch).with("merge_request_diff_ff9_cc9", :expires_in => 60.minutes).returns("some_string")
      assert_equal "some_string", @backend.commit_diff("ff9", "cc9")
    end

    should "ask the cache for diffs for a single commit" do
      Rails.cache.expects(:fetch).with("merge_request_diff_f00", :expires_in => 60.minutes).returns("foo_bar")
      assert_equal "foo_bar", @backend.single_commit_diff("f00")
    end    
  end
end
